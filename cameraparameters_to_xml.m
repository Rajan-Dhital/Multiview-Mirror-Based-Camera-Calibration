% This code convert camera parameter to xml file for tomogrpahic
% reconstructions

num_cams = 5;
docNode = com.mathworks.xml.XMLUtils.createDocument('ext_cal');
toc = docNode.getDocumentElement;

curr_node = docNode.createElement('num_cams');
curr_node.appendChild(docNode.createTextNode(string(num_cams)));
toc.appendChild(curr_node);
[c,imagepoint] = cam1();
for num_of_camera = 1:num_cams
    which_image = [1 2 3 4 5];
    %convert matlab notation to Ihrke notation
    [R2,t2] = extrinsicsToCameraPose(c.RotationMatrices(:,:,which_image(num_of_camera)),c.TranslationVectors(which_image(num_of_camera),:));
    %R2 = c.RotationMatrices(:,:,which_image(num_of_camera));
    %t2 = c.TranslationVectors(which_image(num_of_camera),:);
    product = docNode.createElement('cam');
    toc.appendChild(product);
    cam_child = {'id','name','K','M','R','t'};
    cam_child1 = {'IntrinsicMatrix','RotationMatrices','TranslationVectors'};
    %A = [1,2,3;4,5,6;7,8,9];
    for idx = 1:numel(cam_child)
        curr_node = docNode.createElement(cam_child{idx});
        if idx == 1
            curr_node.appendChild(docNode.createTextNode(string(num_of_camera-1)));
        elseif idx ==2
            curr_node.appendChild(docNode.createTextNode(strcat('cam',string(num_of_camera-1))));
        else
            %for different cameras
            %cam = str2func('cam'+string(num_of_camera));
            
            if idx == 3
                A = c.IntrinsicMatrix';

            elseif idx == 4
                A = [1 0 0;0 1 0;0 0 1];
            elseif idx == 5
                %A = c.RotationMatrices(:,:,which_image(num_of_camera));
                A = R2;
            elseif idx == 6
                %A = c.TranslationVectors(which_image(num_of_camera),:);
                A = t2;
            end
            curr_node.appendChild(docNode.createTextNode(strcat(matrixtostring(A))));
        end
        product.appendChild(curr_node);
    end
end
xmlwrite('ec.xml',docNode);

function return_string = matrixtostring(A)
if size(A,1) ==3
    return_string = ' '+string(size(A,1)) + ' ' + string(size(A,2)) + ' ';
else 
    return_string = ' '+ string(size(A,2)) + ' ';
end
for i = 1:size(A,1)
    for j = 1:size(A,2)
        return_string = return_string  + string(A(i,j))+ ' '; 
    end 
end
end

 
