# sound-location
sound location
The sound source positioning system of microphone array has important applications in array signal processing, and is widely used in artillery fire detection, UAV early warning system, hearing aid, whistle capture and video conference. However, many domestic sound source localization methods only analyze the near-field model, and the localization performance is poor under the interference of noise and reverberation. In order to solve the problem of far-field model location, BP neural network method is used to optimize the time-delay estimation algorithm. The method uses the time difference of the sound received by the microphone array as the input of the network, constructs seven hidden layers for training, and outputs them as two-dimensional coordinates of the sound source position. Finally, the performance test and experiment of the system are carried out. Based on the best real-time generalized quadratic cross- correlation delay estimation positioning algorithm, the factors affecting the positioning accuracy are analyzed. The test results show that under the far-field model, the system designed in this paper can meet the requirements of the initial design. It provides an idea for reducing the influence of ground reflection, wind speed, temperature and atmospheric eddy current when the subsequent signal propagates from the elevated sound source in the lower audio band to the small microphone array near the ground.
1.Establishment of elevated sound source model
1.1 Flow chart of acoustic transmission simulation
![image](https://user-images.githubusercontent.com/88503084/169249157-b77dbecd-eb2a-4504-b1b1-3b89a3439a12.png)
1.2 Sound pressure and sound energy density level
![image](https://user-images.githubusercontent.com/88503084/169248709-34ab0f61-f958-4767-bbf7-6a9021a155f8.png)
1.3 Analysis of simulation results
AC and re values when wind profile Ma = 0.0275 (5bft) (y = 0m) and temperature gradient is 3 ℃ / M
风况	考虑温度梯度	不考虑温度梯度
有风	AC=45.2dB,RE=-33.5dB	AC=44.5dB,RE=-33.8dB
无风	AC=28.7dB,RE=-16.3dB	AC=28.6dB,RE=-16.4dB
AC and re values when wind profile Ma = 0.0275 (5bft) (y = 0m) and temperature gradient is 30 ℃ / M
风况	考虑温度梯度	不考虑温度梯度
有风	AC=46.6dB,RE=-33.4dB	AC=32.6dB,RE=-29.5dB
无风	AC=28.9dB,RE=-16.4dB	AC=26.2dB,RE=-16.3dB
1.4Simulation of array performance
![image](https://user-images.githubusercontent.com/88503084/169249948-4937f68e-015f-4c24-afea-0cb207ce5308.png)
![image](https://user-images.githubusercontent.com/88503084/169249974-6cedf918-e450-4e72-acf2-2e77d9bf3bea.png)
![image](https://user-images.githubusercontent.com/88503084/169249995-7ec501db-8eaa-40d0-a6f2-cc8bf5ddc5a1.png)
![image](https://user-images.githubusercontent.com/88503084/169250025-c912cddb-fd87-4db9-ab1f-b1955385696c.png)
![image](https://user-images.githubusercontent.com/88503084/169250039-c7b72d8b-b3fa-4264-a4ea-408a0696c711.png)
2.Sound source location based on BP neural network
2.1 Establishment of BP neural network model
![image](https://user-images.githubusercontent.com/88503084/169250107-8e22843f-2d59-4732-8b04-1344e2dbc65a.png)
![image](https://user-images.githubusercontent.com/88503084/169250336-48cfe2d5-e035-4a61-91f0-5b5c8be05a29.png)
![image](https://user-images.githubusercontent.com/88503084/169250371-2ad09922-fede-4ce3-bd92-7f918de93908.png)
2.2 Numerical simulation training and positioning test
测试的次数	声源的实际位置（米）	BP神经网络预测的位置（米）
1	(27.61219,23.62804)	(27.47800,23.60720)
2	(53.39716,71.07768)	(53.44843,71.00364)
3	(22.58581,32.72749)	(66.35155,24.40269)
4	(82.34979,51.51410)	(81.84044,51.64457)
5	(24.09694,43.21100)	(24.14910,43.18711)
6	(65.21055,79.87925)	(65.26800,79.49519)
7	(62.89116,54.28664)	(62.89920,54.30437)
8	(15.96562,91.78357)	(15.99209,83.37740)
9	(75.71035,13.92745)	(74.93752,14.10198)
10	(33.18370,90.15070)	(33.14564,87.35687)
![image](https://user-images.githubusercontent.com/88503084/169250530-a2a12d21-e2a8-4cb0-b19d-ecd447ee4a1d.png)
3.System test and experiment
3.1 Construction of experimental platform
![image](https://user-images.githubusercontent.com/88503084/169250695-4b3facf9-f531-4a30-a8db-b15fbbb6a97b.png)
![image](https://user-images.githubusercontent.com/88503084/169250792-d638a07c-539b-4aab-9f33-7902ceeb7c78.png)
3.2 Positioning analysis under different distances and angles
![image](https://user-images.githubusercontent.com/88503084/169250930-8117adfc-9963-4722-87d2-3fb2972564d7.png)
3.3 Positioning analysis under different spacing
![image](https://user-images.githubusercontent.com/88503084/169251039-558a1c68-9d9f-44ad-818c-3bad33a0989b.png)
3.4 Location analysis under different signal-to-noise ratio
![image](https://user-images.githubusercontent.com/88503084/169251148-8020673d-67ad-4027-bec1-84ed698bc7cb.png)


