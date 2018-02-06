function [] = main()

%%  Will take a dt6 and create tensor (FA,MD,AD,RD) and Westin Shape Indices (cl, cp, cs) nifti images from a dt6.mat structure.

switch getenv('ENV')
case 'IUHPC'
  disp('loading paths (HPC)')
  addpath(genpath('/N/u/hayashis/BigRed2/git/vistasoft'))
case 'VM'
  disp('loading paths (VM)')
  addpath(genpath('/usr/local/vistasoft'))
end

%% Set up names and parameters
fileNames = {'fa','md','ad','rd','cl','cp','cs'};
minVal = 1e-6;

%% Load dt6.mat and tensors.nii.gz
config = loadjson('config.json');
dt = dtiLoadDt6(fullfile(config.dt6, '/dti/dt6.mat'));
ni = niftiRead(dt.files.tensors);

%% Compute eigenvectors and eigenvalues from dt6
[eigVec,eigVal] = dtiEig(dt.dt6);

%% Clip all negative eigenvalues to 0
mask = repmat(all(eigVal==0,4),[1 1 1 3]);
eigVal(eigVal<minVal) = minVal;
eigVal(mask) = 0;
clear mask;
dt6 = dtiEigComp(eigVec,eigVal);

%% Compute tensors and Westin Shape Indices
[fa,md,rd,ad] = dtiComputeFA(eigVal);
[cl,cp,cs] = dtiComputeWestinShapes(eigVal, 'lsum');

%% Write nifti images
files={fa,md,ad,rd,cl,cp,cs};
for ii = 1:length(files)
    ni.fname = sprintf('%s.nii.gz',fileNames{ii});
    ni.data = files{ii};
    writeFileNifti(ni);
end

exit;
end
