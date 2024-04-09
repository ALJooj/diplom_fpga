function  build_dataset(image_file,label_file,describe)
 % Прочитать файл изображения обучающего набора
images = fopen(image_file,'r'); 
 % Прочтите информацию описания файла, первые шестнадцать байтов данных - это информация описания
a = fread(images,16,'uint8'); 
 % Описание информации выражается 32-битным целым числом
%MagicNum = ((a(1)*256+a(2))*256+a(3))*256+a(4);
 % Первые четыре байта - это описание формата файла idx
 ImageNum = ((a (5) * 256 + a (6)) * 256 + a (7)) * 256 + a (8);% количество изображений
 rows = ((a (9) * 256 + a (10)) * 256 + a (11)) * 256 + a (12);% количество строк: 28
 cols = ((a (13) * 256 + a (14)) * 256 + a (15)) * 256 + a (16);% количество столбцов: 28
 % Прочитать файл метки обучающего набора
labels =  fopen(label_file,'r'); 
 % Прочитать информацию описания файла, первые восемь байтов
a1 = fread(labels,8,'uint8'); 
 % MagicNum1 = ((a1 (1) * 256 + a1 (2)) * 256 + a1 (3)) * 256 + a1 (4); описание формата файла% idx
 ImageNum1 = ((a1 (5) * 256 + a1 (6)) * 256 + a1 (7)) * 256 + a1 (8);% номер изображения (четыре байта, выраженные 32-битным целым числом)
 % Прочитать информацию о данных
Label = zeros(1,ImageNum1);
data = [];
for i=1:ImageNum    
    im = im2double(fread(images,rows*cols,'uint8'));  
         % Считайте каждый раз данные о размере изображения 28 * 28 как вектор    
         label = fread (labels, 1, 'uint8');% соответствует метке, это значение указывает, какое число от 0 до 9 на картинке
    Label(i) = label;
         im_arr = im ';% преобразовать картинку в хранилище строк
         im_vec = reshape (im_arr, rows * cols, 1);% преобразовано в матрицу    
    data = [data,im_vec];
end
 % Согласно дескриптору, хранить данные
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