## Sparse Self-Expressive Decomposition (SEED) Method

### 1. Setup
- Download and install OMPBox from Rob Rubinstein:
  http://www.cs.technion.ac.il/~ronrubin/Software/ompbox10.zip

- Install oASIS solver:
  https://github.com/nerdslab/oasis

- Add all folders in oASIS, OMPbox, and SEED to your path

### 2. To get started
- To run SEED on a synthetic dataset consisting of a union of subspaces, run uos_demo.m
- To run SEED on a real dataset consisting of a collection of face images under different illumination conditions, run face_demo.m (This face data is taken from a subset of the YaleB face database, http://vision.ucsd.edu/~leekc/ExtYaleDatabase/ExtYaleB.html)

### 3. References
The paper associated with SEED:
E.L. Dyer, T.A. Goldstein, R. Patel, K.P. Kording, R.G. Baraniuk,"Self-Expressive Decompositions for Matrix Approximation and Clustering", http://arxiv.org/abs/1505.00824

The paper associated with our column sampling method oASIS:
R. Patel, T.A. Goldstein, E.L. Dyer, A. Mirhoseini, R.G. Baraniuk, Deterministic Column Sampling for Low-Rank Matrix Approximation: Nyström vs. Incomplete Cholesky Decomposition, http://epubs.siam.org/doi/abs/10.1137/1.9781611974348.67

** Code and examples for the sampling method (oASIS) used in SEED can be found at: http://github.com/nerdslab/oasis **
