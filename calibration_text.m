
fid = fopen( 'objectSR_par.txt', 'wt' );
%fclose(fid)
create_textfile(fid,cam3(),1,1);
fprintf( fid, '\n' );
create_textfile(fid,cam3(),2,2);
fprintf( fid, '\n' );
create_textfile(fid,cam3(),3,3);
fprintf( fid, '\n' );
create_textfile(fid,cam3(),4,4);
fprintf( fid, '\n' );
create_textfile(fid,cam3(),5,5);
fclose(fid)
function create_textfile(fid,cameraParams,index,m)
R2 = cameraParams.RotationMatrices(:,:,index);
I2 = cameraParams.IntrinsicMatrix;
%I2 = I2';
T2 = cameraParams.TranslationVectors(index,:);
%[R2, T2] = extrinsicsToCameraPose(R2,T2);



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
for i = 1:size(T2,2)
    fprintf( fid, '%d ', T2(i));
end
end