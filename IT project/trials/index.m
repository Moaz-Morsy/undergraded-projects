clear all;
close all
clc;
% Input matrix
A = [ 1 3 5; 9 7 6; 2 8 4];
% Sort. Transform A into a vector with (:)
[B,IX] = sort(A(:), 'ascend');
% Convert linear indices to subscript
[I,J] = ind2sub(size(A),IX);
% Display n first elements
for i=1:3
  fprintf('Element %d: %d at row %d and column %d\n', i, B(i), I(i), J(i));
end