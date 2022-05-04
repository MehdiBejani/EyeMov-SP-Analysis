# EyeMov-SP-Analysis
This is a project for analyzing the smooth pursuit eye movements


It contained these files:
1-	main_complixity: the main code for importing the DAT format data and events in MATLAB. Removing the first and last quarter of it. Extracting the left and right eye and x and y axes signals. Plotting the signals with events, BW removing of them and extracting different features of them.
2-	BW_removing: A function for removing the BW of the signals by different methods.
3-	ExtractFeatuers: A function for extracting different features: time domain features, nonlinear and complexity features (DFA, RQA, different entropies, fractal).
In folder “Manipulating BW by Hand” there are some codes and functions for editing and manipulating BW of the signals by hand.
