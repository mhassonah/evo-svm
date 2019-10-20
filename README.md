# evo-svm
Evolutionary Support Vector Machine

* Developed in Matlab R2015a  (8.5.0. 196713)
* Developed by: Mohammad A. Hassonah (mohammad.a.hassonah@gmail.com), Ala' M. Al-Zoubi (alaah14@gmail.com) and Hossam Faris (7ossam@gmail.com)
* Cite as: **Faris, H., Hassonah, M. A., Ala’M, A. Z., Mirjalili, S., & Aljarah, I. (2018). A multi-verse optimizer approach for feature selection and optimizing SVM parameters based on a robust system architecture. Neural Computing and Applications, 30(8), 2355-2369.** 
* DOI: https://doi.org/10.1007/s00521-016-2818-2

#### Guide:
* This project includes the implementation of many Metaheuristic Algorithms (MAs) on Support Vector Machine (SVM) algorithm.
* In this project, MAs are utilized in tuning (optimizing) SVM parameters and/or selecting features for minimization and maximization problems.
* This project uses LibSVM library.
* Main file to run is 'evo-svm.m'. Edit directory path to LibSVM toolbox, and Datasets folder. Specify all needed parameters in this file as well.
* User can add or remove as many MAs as needed. Make sure to add them in the 'evo_algorithms' folder and call them in code as shown for other algorithms. Also make sure that all files' names are unique in the entire project.
* This project uses paralell For loop for separate experiments in Matlab. 
