digitDatasetPath = 'C:\Users\Zatoichi\3D Objects\neural network';
digitImages = imageDatastore(digitDatasetPath, 'IncludeSubfolders', true, 'LabelSource','foldername');

numTrainFiles = 750;
[TrainImages, TestImages] = splitEachLabel(digitImages, numTrainFiles, 'randomize');

layers = [
    imageInputLayer([28 28 1], 'Name', 'Input');
    
    convolution2dLayer(3,8,'Padding','same','Name','Conv_1');
    reluLayer('Name', 'Relu_1');
    maxPooling2dLayer(2,'Stride',2,'Name','MaxPooling_1');
    
    convolution2dLayer(3,16,'Padding','same','Name','Conv_2');
    batchNormalizationLayer('Name', 'BN_2');
    reluLayer('Name', 'Relu_2');
    maxPooling2dLayer(2,'Stride',2,'Name','MaxPooling_2');
    
    fullyConnectedLayer(10, 'Name', 'FC');
    softmaxLayer('Name', 'Softmax_2');
    classificationLayer('Name', 'Output Classification');
];


lgraph = layerGraph(layers);
plot(lgraph);

options = trainingOptions('sgdm','InitialLearnRate',0.01,'MaxEpochs', 4, 'Shuffle', ...
'every-epoch', 'ValidationData', TestImages, 'ValidationFrequency', ...
30, 'Verbose',false, 'Plots', 'training-progress');

net = trainNetwork(TrainImages, layers, options);
YPred = classify(net, TestImages);
YValidation = TestImages.Labels;
accuracy = sum(YPred == YValidation)/numel(YValidation);












