import os
import sys

def getFlagsWithDefValue(file) -> dict:
    result = {}

    for line in file:
        pare = getKeyFromLine(line)
        if len(pare) == 2:
            result[pare[0]] = pare[1]

    return result

def getKeyFromLine(line:str) -> list:
    result = []

    key = ""
    defValue = ""

    colonIndex = line.find(':')
    keyStartIndex = line.find('<')
    keyEndIndex = line.find('>', keyStartIndex)

    if colonIndex != -1 and keyStartIndex != -1 and keyEndIndex != -1:
        for i in range(keyStartIndex, keyEndIndex+1):
            key+=line[i]

        for i in range(colonIndex+1, keyStartIndex-2):
            defValue += line[i]

        result.append(key)
        result.append(defValue)

    preprocessedLines.append(clearParametres(line, defValue))

    return result

def removeSubStr(line:str, sub:str) -> str:
    result = ""

    subStrStartIndex = line.find(sub)
    if subStrStartIndex != -1:
        subStrEndIndex = subStrStartIndex + len(sub)
        for i in range(len(line)):
            if i < subStrStartIndex or i > subStrEndIndex-1:
                result += line[i]
    else:
        result = line

    return result

def clearParametres(line:str, defValue) -> str:
    tmp = removeSubStr(line, defValue)
    tmp = removeSubStr(tmp, "/*")
    tmp = removeSubStr(tmp, "*/")
    return tmp

def createModuleFileName(dirToSave:str ,filename:str) -> str:
    result = dirToSave + filename
    result += "_module.module"
    return result

def createDefParamsFileName(dirToSave:str, filename:str) -> str:
    result = dirToSave + "defparams_"
    result += filename
    result += "_module.txt"
    return result

def createModuleDir(parentDir, modulename) -> None:
    fullPath = parentDir + "\\" + modulename
    print(fullPath)
    try:
        os.mkdir(fullPath)
    except OSError:
        print ("Создать директорию %s не удалось" % fullPath)
    else: 
        print ("Успешно создана директория %s " % fullPath)

def validateCommandsEntered(argv:list) -> bool:
    if len(argv) > 1:
        argv.append("-nocommand")
        return True
    else: 
        return False

def createDictFromCommands(commands:list) -> dict:
    result = {}

    for i in range(len(commands)):
        commandlet = getComandletFromCommand(commands[i])
        commansSplitter = commands[i].split(" ")
        for j in range(1, len(commansSplitter)):
            result[commansSplitter[j]] = commandlet

    return result

def getArguments(command:str) -> list:
    result = []

    if command.count(" ") > 1:
        return False
    else:
        if command.find(" ") == -1:
            return False
        else:
            argumentStartIndex = command.find(" ")
            for i in range(argumentStartIndex, len(command)):
                if command[i] != " ":
                    result += command[i]

    return result

def getComandletFromCommand(command:str):
    result = ""

    if command.find('-') == 0:
        for i in range(len(command)):
            if command[i] == " ":
                break
            else:
                result += command[i]
    else:
        return False

    return result

def createCommands(argv:list) -> list:
    result = []

    command = ""
    commandlet = ""

    commandletsIndexes = []

    for i in range(len(argv)):
        if getComandletFromCommand(argv[i]) != False:
            commandletsIndexes.append(i)

    for i in range(len(commandletsIndexes) - 1):
        commandlet = argv[commandletsIndexes[i]]
        command = ""
        for j in range(commandletsIndexes[i] + 1, commandletsIndexes[i+1]):
            command += argv[j] + " "
        command = command.removesuffix(" ")
        result.append(commandlet + " " + command)

    return result

def validateCommandsList(argv:list) -> dict:
    commandsDict = createDictFromCommands(createCommands(argv))
    commandKeys = list(commandsDict.values())
    uniqueCommandKeys = []
    for uniqueCommandlet in commandKeys:
        uniqueCommandKeys.append(uniqueCommandlet)
    requiredCommandsKeys = list(requiredCommands.keys())

    countedCommandKeys = {}

    print(uniqueCommandKeys)

    for i in range(len(uniqueCommandKeys)):
        emptyArgumentOffset = 0 
        if uniqueCommandKeys[i] in requiredCommandsKeys:
            if uniqueCommandKeys[i] == "--parseall":
                emptyArgumentOffset = -1
            countedCommandKeys[uniqueCommandKeys[i]] = commandKeys.count(uniqueCommandKeys[i]) + emptyArgumentOffset
        else:
            return False

    for i in range(len(uniqueCommandKeys)):
        print(requiredCommands[uniqueCommandKeys[i]])
        print(countedCommandKeys[uniqueCommandKeys[i]])
        if requiredCommands[uniqueCommandKeys[i]] != countedCommandKeys[uniqueCommandKeys[i]]:
            return False

    if not validateCommandCombination(commandsDict):
        return False

    return commandsDict
    
def createmModule(fileName):
    with open("..\\..\\app\\lib\\modules\\" + fileName, "r") as file:
        map = getFlagsWithDefValue(file)
        filename = file.name.removesuffix(".dart")
        filename = filename.removeprefix("..\\..\\app\lib\\modules\\")
        moduleDirPath = resourcesDirPath + "\\" + filename + "_module\\"
        createModuleDir(resourcesDirPath, filename + "_module")
        file.close()

    with open(createDefParamsFileName(moduleDirPath, filename), "w") as output:
        for i in range(len(map)):
            line = list(map.keys())[i] + " = " + list(map.values())[i] + "\n"
            output.writelines(line)
        output.close()

    with open(createModuleFileName(moduleDirPath, filename), "w") as outputModule:
        for i in range(len(preprocessedLines)):
            outputModule.writelines(preprocessedLines[i])
        outputModule.close

#validation for commands

def validateCommandCombination(commandDict:dict) -> bool:
    commandDictValues = list(commandDict.values())

    if commandDictValues.count("--filename") == 1 and commandDictValues.count("--parseall") == 1:
        return False
    
    return True

def validateFileName(argument:str) -> bool:
    try:
        file = open("..\\..\\app\\lib\\modules\\" + argument, "r")
    except OSError:
        print ("No such file")
    else: 
        file.close()
        print ("File found start preprocessing")
        return True

requiredCommands = {
    "--filename" : 1,
    "--parseall" : 0
}

preprocessedLines = []
filename = ""
validatedCommandsDict = {}
resourcesDirPath = os.getcwd()
resourcesDirPath = resourcesDirPath.removesuffix("\preprocessor") + "\resources"
map = {}

if validateCommandsEntered(sys.argv):  
    validatedCommandsDict = validateCommandsList(sys.argv)
    if validatedCommandsDict != False:
        print(list(validatedCommandsDict.values()))
        if list(validatedCommandsDict.values())[0] == "--filename":
            if validateFileName(list(validatedCommandsDict.keys())[0]):
                filename = list(validatedCommandsDict.keys())[0]
                createmModule(filename)
        elif list(validatedCommandsDict.values())[0] == "--parseall":
            path = "..\..\app\lib\modules"
            for _,_,files in os.walk(path):
                print(files)
                for i in range(len(files)):
                    if validateFileName(files[i]):
                        preprocessedLines = []
                        createmModule(files[i])