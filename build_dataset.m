function  build_dataset(image_file,label_file,describe)
 % ��������� ���� ����������� ���������� ������
images = fopen(image_file,'r'); 
 % �������� ���������� �������� �����, ������ ����������� ������ ������ - ��� ���������� ��������
a = fread(images,16,'uint8'); 
 % �������� ���������� ���������� 32-������ ����� ������
%MagicNum = ((a(1)*256+a(2))*256+a(3))*256+a(4);
 % ������ ������ ����� - ��� �������� ������� ����� idx
 ImageNum = ((a (5) * 256 + a (6)) * 256 + a (7)) * 256 + a (8);% ���������� �����������
 rows = ((a (9) * 256 + a (10)) * 256 + a (11)) * 256 + a (12);% ���������� �����: 28
 cols = ((a (13) * 256 + a (14)) * 256 + a (15)) * 256 + a (16);% ���������� ��������: 28
 % ��������� ���� ����� ���������� ������
labels =  fopen(label_file,'r'); 
 % ��������� ���������� �������� �����, ������ ������ ������
a1 = fread(labels,8,'uint8'); 
 % MagicNum1 = ((a1 (1) * 256 + a1 (2)) * 256 + a1 (3)) * 256 + a1 (4); �������� ������� �����% idx
 ImageNum1 = ((a1 (5) * 256 + a1 (6)) * 256 + a1 (7)) * 256 + a1 (8);% ����� ����������� (������ �����, ���������� 32-������ ����� ������)
 % ��������� ���������� � ������
Label = zeros(1,ImageNum1);
data = [];
for i=1:ImageNum    
    im = im2double(fread(images,rows*cols,'uint8'));  
         % �������� ������ ��� ������ � ������� ����������� 28 * 28 ��� ������    
         label = fread (labels, 1, 'uint8');% ������������� �����, ��� �������� ���������, ����� ����� �� 0 �� 9 �� ��������
    Label(i) = label;
         im_arr = im ';% ������������� �������� � ��������� �����
         im_vec = reshape (im_arr, rows * cols, 1);% ������������� � �������    
    data = [data,im_vec];
end
 % �������� �����������, ������� ������
if describe == "train"
    x_train = data;
    y_train = Label;
    save("e:/minist/train_data","x_train","y_train");
end
if describe == "test"
    x_test = data;
    y_test = Label;
    save("e:/minist/test_data","x_test","y_test");
end
end