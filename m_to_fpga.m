snet = net;
analyzeNetwork(snet);
hTarget = dlhdl.Target('Intel');
hW = dlhdl.Workflow('network', snet, 'Bitstream', 'zcu102_single','Target',hTarget);
a = webcam;



