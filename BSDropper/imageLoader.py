import os
import shutil

currentPath = os.getcwd()
print("currentPath : ", currentPath)

assetPath = currentPath + "/Assets"
print("assetPath : ", assetPath)

def files(path):
    for file in os.listdir(path):
        if os.path.isfile(os.path.join(path, file)):
            yield file
        else:
            if file.endswith('.imageset'):
                print("check done ")
                fullpath = assetPath + "/" + file
                print fullpath

                for assetsFile in os.listdir(fullpath):
                    if assetsFile.endswith('.png'):
                        imageFullPath = fullpath + "/" + assetsFile
                        print("assetsFile: ", imageFullPath)
                        shutil.copy(imageFullPath, assetPath)










for file in files(assetPath):
    print (file)


# files(assetPath)
