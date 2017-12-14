Read Me !!

1. Setup
- Download and install OMPBox from Rob Rubinstein:
  http://www.cs.technion.ac.il/~ronrubin/Software/ompbox10.zip

- Download and install oASIS solver:
  https://bitbucket.org/rjp2/oasis/

- Add all folders in oASIS, OMPbox, and SEED to your path

2. To get started
- To run SEED on a synthetic dataset consisting of a union of subspaces, run uos_demo.m
- To run SEED on a real dataset consisting of a collection of face images under different illumination conditions, run face_demo.m (This face data is taken from a subset of the YaleB face database, http://vision.ucsd.edu/~leekc/ExtYaleDatabase/ExtYaleB.html)

3. References
The paper associated with SEED:
E.L. Dyer, T.A. Goldstein, R. Patel, K.P. Kording, R.G. Baraniuk,"Self-Expressive Decompositions for Matrix Approximation and Clustering", http://arxiv.org/abs/1505.00824

The paper associated with our column sampling method oASIS:
R. Patel, T.A. Goldstein, E.L. Dyer, A. Mirhoseini, R.G. Baraniuk, "oASIS: Adaptive Column Sampling for Kernel Matrix Approximation", http://arxiv.org/abs/1505.05208

** Code and examples for the sampling method (oASIS) used in SEED can be found at: https://bitbucket.org/rjp2/oasis/