img = imread("../tests/in/sample1.png");
x = dlmread("../tests/in/factorx1.txt");
y = dlmread("../tests/in/factory1.txt");
resized = bicubic_resize(img, x, y);
resized_ref = dlmread("../tests/ref/bicubic/resized1.txt");

