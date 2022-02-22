
import seaborn as sns
import subprocess


def checkLog(completedProcess):
    """
    Tcheck if everything was ok.
  
    Args:
        completedProcess (obj): Instance of CompletedProcess send by subprocess.run().
  
    """
    try :
        completedProcess.check_returncode()
        print(completedProcess.stdout)
    except subprocess.CalledProcessError as exc:
                print(exc)  
                print(completedProcess.stderr) 

# load the
iris = sns.load_dataset("iris")
path2file = "./data/iris.csv"

# save this to a file
iris.to_csv("./data/iris.csv")

# Write the command to call R on your dataset in this file.
Rcommand ="Rscript Module5.R --file="+path2file

# Make a Call
R = subprocess.run((Rcommand),stdout=subprocess.PIPE, stderr=subprocess.PIPE,universal_newlines=True,shell=True)

# Check Everything went well (custom function I used several times in past projects)
checkLog(R)
