%This code visualizes the camera poses in the world coordinate system. 

hold on
% plot checkerboard point
for i = 0:17
    for j = 0:8
        plot3(i*15,j*15,0,'o')
    end 
end
camindex = [1,1,1,1,1];
fidcamera = fopen( 'camera_parameters.txt', 'wt' );

fid = fopen( 'objectSR_par.txt', 'wt' );
fidR = fopen( 'Rotation.txt', 'wt' );
fidt = fopen( 'Translation.txt', 'wt' );
fidI = fopen( 'Intrinsic.txt', 'wt' );
[c1,imagepointss1] = cam1();

for i = [ 1 2 3 4 5]
    cameracoordinat(c1,imagepointss1,i,fid,c1,fidR,fidt,fidI);
end
hold off

%plot camera pose

function cameracoordinat(c,imagepoint1,m,fid,c3,fidR,fidt,fidI)

I2 = c3.IntrinsicMatrix;
R2 = c.RotationMatrices(:,:,m);
t2 = c.TranslationVectors(m,:);

rotation(R2,fidR);
translation(t2,fidt);
Intrinsic(I2,fidI);

%camera coordinate in pattern centric
origin = -t2* inv(R2);
xaxis = ([105 0 0] -t2)*inv(R2);
yaxis = ([0 105 0] - t2)*inv(R2);
zaxis = ([0 0 105] - t2)*inv(R2);
text(origin(1),origin(2),origin(3),'cam'+string(m))


pts = [origin; xaxis];
plot3(pts(:,1), pts(:,2), pts(:,3),"red")
plot3(origin(1),origin(2),origin(3),'o')

pts = [origin; yaxis];
plot3(pts(:,1), pts(:,2), pts(:,3),'green')
pts = [origin; zaxis];
plot3(pts(:,1), pts(:,2), pts(:,3),'blue')

%save camera parameters

fprintf( fid, '%s ', 'sill'+string(m)+'.png');
for i = 1:size(I2,1)
    for j = 1:size(I2,2)
        fprintf( fid, '%d ', I2(i,j));
    end
end
for i = 1:size(R2,1)
    for j = 1:size(R2,2)
        fprintf( fid, '%d ', R2(i,j));
    end
end
for i = 1:size(t2,2)
    fprintf( fid, '%d ', t2(i));
end
fprintf( fid, '\n' );
end

function rotation(R2,fid)
for j = 1:3
    for k = 1:3
        fprintf(fid, '%d',R2(j,k));
        fprintf(fid, ' ');
    end
    fprintf( fid, '\n' );
end
end
function translation(t2,fid)
for k = 1:3
    fprintf(fid, '%d',t2(1,k));
    fprintf(fid, ' ');
end
fprintf( fid, '\n' );
end

function Intrinsic(I2,fid)
for j = 1:3
    for k = 1:3
        fprintf(fid, '%d',I2(j,k));
        fprintf(fid, ' ');
    end
    fprintf( fid, '\n' );
end
end

function cameraparameter(P,fid)
for j = 1:size(P,1)
    for k = 1:size(P,2)
        fprintf(fid, '%d',P(j,k));
        fprintf(fid, ' ');
    end
        
        fprintf( fid, '\n' );
end
end

function imagepoint(P,fid)
for j = 1:size(P,1)
    for k = 1:size(P,2)
        fprintf(fid, '%d',P(j,k));
        fprintf(fid, ' ');
    end
        
        fprintf( fid, '\n' );
end
end

