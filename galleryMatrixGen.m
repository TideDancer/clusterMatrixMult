function [A B] = galleryMatrixGen(dim, id);

[A B] = gallery('randsvd', dim ,kappa, mode)
