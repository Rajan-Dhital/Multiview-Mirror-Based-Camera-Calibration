hold on
for i = 0:17
    for j = 0:8
        plot3(i*15,j*15,0,'o')
    end 
end
camindex = [1,1,1,1,1];
fid = fopen( 'objectSR_par.txt', 'wt' );
fidR = fopen( 'Rotation.txt', 'wt' );
fidt = fopen( 'Translation.txt', 'wt' );
fidI = fopen( 'Intrinsic.txt', 'wt' );
[c1,imagepointss1] = cam1();
% [c2,imagepointss2] = cam2();
% [c3,imagepointss3] = cam3();
% [c4,imagepointss4] = cam4();
% [c5,imagepointss5] = cam5();
for i = [  1 2 3 4 5 ]
%     c = eval('c'+string(i));
%     imagepoint = eval('imagepointss'+string(i));
    cameracoordinat(c1,imagepointss1,i,fid,c1,fidR,fidt,fidI);
end
hold off


for i = 1:5
    %imagepoint = eval('imagepointss'+string(i));
    fid = fopen( 'imgpoints'+string(i)+'.txt', 'wt' );
    for j = 1:size(imagepointss1,1)
        fprintf( fid, '%d ',imagepointss1(j,:,1) );
        fprintf( fid, '\n' );

    end
end


function cameracoordinat(c,imagepoint1,m,fid,c3,fidR,fidt,fidI)
position = [1 2 0 3 4];
I2 = c3.IntrinsicMatrix;
    if m~=3
        if m==1 || m ==5
            imagepoints1 = imagepoint1(:,:,3);
            imagepoints2 = imagepoint1(:,:,m);
        else
            imagepoints1 = imagepoint1(:,:,3);
            imagepoints2 = imagepoint1(:,:,m);
        end
        [M,inliersIndex] = estimateEssentialMatrix(imagepoints1,imagepoints2,c);
        %[M,inliersIndex] = estimateFundamentalMatrix(imagepoint1(:,:,n),imagepoint1(:,:,m),Method="LMedS");
%         imgpoint1 = [];
%         for i = 7:12
%             imgpoint1 = vertcat(imgpoint1,imagepoint1(:,:,i));
%         end
% % 
%         imgpoint2 = [];
%         for i = 1:6
%             imgpoint2 = vertcat(imgpoint2,imagepoint1(:,:,i));
%         end
%         if m ==2
%             temp = imgpoint1;
%             imgpoint1 = imgpoint2;
%             imgpoint2 = temp;
%         end
%         
%         [M,inliersIndex] = estimateFundamentalMatrix(imgpoint1, ...
%         imgpoint2,Method="Norm8Point", ...
%         NumTrials=2000,DistanceThreshold=1e-4);
%         [M,inliersIndex] = estimateEssentialMatrix(imgpoint1,imgpoint2,c);
        %M = estimateGeometricTransform2D(imgpoint1,imgpoint2,'projective');
        count = 1;
        imagepoint_temp1 = [];
        imagepoint_temp2 = [];
        for i = 1:size(inliersIndex,1)
            if inliersIndex(i)==1
                imagepoint_temp1(count,:) = imagepoints1(i,:);
                imagepoint_temp2(count,:) = imagepoints2(i,:);
                count = count + 1;
            end
        end
        [relativeOrientation,relativeLocation] = relativeCameraPose ...
        (M,c,imagepoint_temp1,imagepoint_temp2);
        
         R1 = c.RotationMatrices(:,:,3);
%          t1 = c3.TranslationVectors(1,:);
%         t1 = c.TranslationVectors(1,:);
         R2 = c.RotationMatrices(:,:,m);
%         t2 = c.TranslationVectors(m,:);
         %[R1, t1] = extrinsicsToCameraPose(R1,t1);
%         eul = radtodeg(rotm2eul(R2));
%         eul = [degtorad(0) degtorad(0) degtorad(position(m)*72)];
%         R2 = eul2rotm(eul);
        %eul(3) = degtorad(0);
        %R2 = eul2rotm(eul);
%         [R2, t2] = cameraPoseToExtrinsics(R2,t2);
%         T = ([0 20 0]*R1+t1)*I2;
%         T = T/T(3);
% 
%         cameraextrinsic1 = rigid3d(R1, t1);
%         camMatrix1 = cameraMatrix(c, cameraextrinsic1);
%         cameraextrinsic2 = rigid3d(R2, t2);
%         camMatrix2 = cameraMatrix(c, cameraextrinsic2);

% 
% 
        Rr = relativeOrientation;
        tr = relativeLocation;
        %R2 = R1*Rr';
        t2 = c.TranslationVectors(m,:);
        %M = [-1 0 0;0 1 0;0 0 1];
        if m == 1 || m == 5
            %R2 = R2*M;
            %t2 = t2*M;
%             [U,D,V] = svd(M);
%             W = [0 -1 0;1 0 0;0 0 1];
%             Rs1 = U*W*V';
%             Rs2 = U*W'*V';
%             R2 = R1*Rs2';
            %R2 = R1*Rr;
        %R2 = R2*roty(180);
        end
        rotation(R2,fidR);
        translation(t2,fidt);
        Intrinsic(I2,fidI);
        %t2 = t1*Rr'+tr;
        %[R2, t2] = cameraPoseToExtrinsics(R2,t2);

%         T = ([0 0 0]*R1+t1)*I2;
%         T1 = [0 60 0]*R1+t1;
%         T = T/T(3);

        %[R2, t2] = cameraPoseToExtrinsics(relativeOrientation,relativeLocation*1000);

        %cameraextrinsic2 = rigid3d(R2, t2);
        %camMatrix2 = cameraMatrix(c, cameraextrinsic2);

%         points3D = triangulate(imagepoint1(:,:,1), imagepoint1(:,:,2), camMatrix1,camMatrix2);

        %d = norm(points3D(1:6,:));


        %tr = tr*10000*(22/d);
        %t2 = t1;
        %[R2, t2] = cameraPoseToExtrinsics(Rr,tr*500);
        %R2 = R1*Rr;
        %t2 = t1*Rr+tr;
        %[R2, t2] = cameraPoseToExtrinsics(R2,t2);
        %R2 = c.RotationMatrices(:,:,m);
        %t2 = c.TranslationVectors(m,:);
        %[R2, t2] = extrinsicsToCameraPose(R2,t2);


    else
        R2 = c.RotationMatrices(:,:,m);
        t2 = c.TranslationVectors(m,:);
        rotation(R2,fidR);
        translation(t2,fidt);
        Intrinsic(I2,fidI);
        %[R2, t2] = extrinsicsToCameraPose(R2,t2);
%         eul = radtodeg(rotm2eul(R2));
%         eul = [degtorad(0) degtorad(0) degtorad(position(m)*72)];
%         R2 = eul2rotm(eul);
%         [R2, t2] = cameraPoseToExtrinsics(R2,t2);
    end
    %camera coordinate in camera centric
%     origin = t2;
%     xaxis = [105 0 0] * R2 + t2;
%     yaxis = [0 105 0] * R2 + t2;
%     zaxis = [0 0 105] * R2 + t2;


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

