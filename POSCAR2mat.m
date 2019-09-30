% Input Folder containing POSCAR files data
POSCAR_folder = 'C:\Users\Asma\Desktop\POSCAR2mat\POSCAR_data';
% Initialize mat file
MH = []
for i=1:8
    ii = num2str(i)
    file = strcat(POSCAR_folder,'\','POSCAR', ii)

    delimiter = ' ';



    %% Format for each line of text:
    formatSpec = '%s%s%s%[^\n\r]';

    %% Open the text file.
    fileID = fopen(file,'r');

    %% Read columns of data according to the format.

    dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'MultipleDelimsAsOne', true, 'ReturnOnError', false);

    %% Close the text file.
    fclose(fileID);

    %% Create output variable
    POSCAR = [dataArray{1:end-1}];
    labels = POSCAR(1,:)
    labels(3) = []
    weights = str2double(POSCAR(6,:))
    weights(3) = []

    POSCAR(1,:) = []
    POSCAR(1,:) = []
    POSCAR(4,:) = []
    POSCAR(4,:) = []
    
    POSCAR = cellfun(@str2double,POSCAR)
    abc = POSCAR(1:3,:)
    coord = POSCAR(4:end,1:3)
    if labels{1} == 'Pd' 
    %Please change the atom "Pd" with your studied chemical element 
        M = coord(1:weights(1),1:3)
        [sz1,sz2] = size(M)
        if sz1<18            
            sz = 18-sz1
            M=[M;zeros(sz,3,'double')]
        end
        H = coord(weights(1)+1:end,1:3)
    elseif labels{1} == 'H'
        H = coord(1:weights(1), 1:3);
        M = coord(weights(1)+1:end,1:3)
        [sz1,sz2] = size(M)
        if sz1<18            
            sz = 18-sz1
            M=[M;zeros(sz,3,'double')]
        end
    end
    Z = zeros(18,3,'double')
%    M = [M;Z]
%     [sz1,sz2] = size(M)
%     if sz1<36
%         sz = 36-sz1
%         M=[M;zeros(sz,3,'double')]
%     end

    output = {abc,H,M,Z}
    MH = [MH; output]

end
%% Clear temporary variables
clearvars filename delimiter formatSpec fileID d dataArray abc  M weights atoms  file coord sz sz1 sz2  H  Z POSCAR_folder  i ii labels output POSCAR  str x y ans;
%% Convert and save POSCAR data into .mat file
% CrystalGAN input file
%save('MH', 'MH')



