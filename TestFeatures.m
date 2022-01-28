load('Outputs/ScatterFeatures/Data_Features.mat');
load('Outputs/ScatterFeatures/Data_Tags.mat');
Scatter_Features(ALL_IM_FMS.normal, Tags, Headers,2, 6, '','normal', 'p')
Scatter_Features(ALL_IM_FMS.color,  Tags, Headers,2, 6, '','color' , 'p')
Scatter_Features(ALL_IM_FMS.norcol, Tags, Headers,2, 6, '','norcol', 'p')
Scatter_Features(ALL_IM_FMS.normal, Tags, Headers,2, 4, 'UD','normal', 'p')
Scatter_Features(ALL_IM_FMS.color,  Tags, Headers,2, 4, 'UD','color' , 'p')
Scatter_Features(ALL_IM_FMS.norcol, Tags, Headers,2, 4, 'UD','norcol', 'p')
%%
Scatter_Features(ALL_IM_FMS.normal, Tags, Headers,5, 6, '','normal', 'p')