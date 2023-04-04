# Camera-calibration-of-the-reflected-images
Single reflected images are first flipped to undo the reflection.<br />
Modification of matlab camera calibration for backside checkerboard images.<br />
Camera calibration steps.<br />
1. Square checkerboard of 20mm on both side.<br />
2. Checkerboard placed in between the mirrors.<br />
3. Capture all the reflected checkerboards.<br />
4. Split the image into five with equal dimensions.<br />
5. flip the single reflected images.<br />
6. Separated checkerboard images are fed into Matlab for  calibration.<br />
7. Modification of Matlab calibration for backside view of the checkerboard image.<br />
8. Matlab assigns number for the corners.<br />
9. Incorrect assignment of number for back view.<br />
10. After modification assignment of correct numbering.<br />
![Screenshot from 2022-10-12 17-54-13](https://user-images.githubusercontent.com/87676441/196914100-32afa4ae-8d28-4827-93b5-74c1172c436a.png)
![Screenshot from 2022-10-12 17-56-28](https://user-images.githubusercontent.com/87676441/196914306-3e323834-4278-419b-ab39-a39fca6c56ea.png)
![cameraorientation](https://user-images.githubusercontent.com/87676441/196914521-0c2a6d14-9dea-4b70-9f9b-49ff4120ab2e.png)
