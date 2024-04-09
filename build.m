function build()
load("e:/minist/test_data");
[m,n] = size(x_test);
for k = 1:n
    x = x_test(:,k);
    x = reshape(x,28,28);
    x = uint8(x);
    imwrite(x',"e:/minist/image/"+k+".bmp");
end
end
