%main_path = ['F:\X-ray images new\6_Slices\Slices'];

main_path ='D:\Studienarbeit\Input\6_Slices';
% extract the information from 10 images samples in the main_path default
% 20


%>checked
%1) ein wenig unglücklich gelöst da in xpath die daten für broad und narrow
%       geladen werden - daher ist xpath 2*AnzahlderSamples
%2) um den rand der anode zu finde wird der mittelwert über columns ermittelt
%       und mit einem Schwellwert verglichen (20&30) vermutlich Trial&error   
%       Ergbnis: index des Randbildes von links und rechts
%3) für ypath wird der Startindex festgelegt für das Bild was die
%       Bedingungen für oben und unten gleichteitig erfüllt analog zu 2)
%4) für zpath werden Bilder aus der einem bestimmten Bereich des Sets
%       genommen(auch die Anzahl ist eher lachs definiert)

%[x_path,y_path,z_path] = images_to_process(main_path,10);
[x_path,y_path,z_path] = images_to_process_new(main_path,10);

%1) Bildverarbeitung erfolgt durch Grayscale-Adjustment(nicht stretching
%       wie in der Doc) Es wird bei dem Grauwert der Hülle(ganz rechts)
%       abgeschnitten. 

[distance_narrow_X,distance_broad_X] = edge_extraction_from_X(x_path);
[distance_narrow_Y,distance_broad_Y] = edge_extraction_from_Y(y_path);
image_acquisition_angle = image_acquisition_angle_extraction(z_path);

% distance correction through Z-angle
actual_distance_narrow_Y = distance_narrow_Y*cos((90+image_acquisition_angle)/180*pi);
actual_distance_broad_Y = distance_broad_Y*sin((90+image_acquisition_angle)/180*pi);
actual_distance_narrow_X = distance_narrow_X * sin((90+image_acquisition_angle)/180*pi);
actual_distance_broad_X = distance_broad_X*cos((90+image_acquisition_angle)/180*pi);

% outlier removal
    %actual_distance_narrow_test = outlier_removal(actual_distance_narrow_Y);
    %bos = actual_distance_narrow_Y-actual_distance_narrow_test;
actual_distance_narrow_Y = outlier_removal(actual_distance_narrow_Y);
actual_distance_broad_Y = outlier_removal(actual_distance_broad_Y);
actual_distance_narrow_X = outlier_removal(actual_distance_narrow_X);
actual_distance_broad_X = outlier_removal(actual_distance_broad_X);

% overlapping rate evaluation

electrode_length = 145;
electrode_width = 105;
resolution = 25;

overlapping_X = overlapping_rate_evaluation(actual_distance_narrow_X,actual_distance_broad_X, electrode_length, electrode_width, resolution);
overlapping_Y = overlapping_rate_evaluation(actual_distance_narrow_Y,actual_distance_broad_Y, electrode_length, electrode_width, resolution);


% data export
%export_path = 'E:\x-ray images\edge extraction\cell 6';
export_path = 'D:\Studienarbeit\Output'
mkdir(export_path)

save([export_path,'\','distances_between_electrodes.mat'],'image_acquisition_angle',...
    'actual_distance_narrow_Y','actual_distance_broad_Y','actual_distance_narrow_X','actual_distance_broad_X',...
    'overlapping_X','overlapping_Y')

