[![Abcdspec-compliant](https://img.shields.io/badge/ABCD_Spec-v1.1-green.svg)](https://github.com/soichih/abcd-spec)
[![Run on Brainlife.io](https://img.shields.io/badge/Brainlife-bl.app.1-blue.svg)](https://doi.org/10.25663/bl.app.1)

# app-dt6tonifti
This app will take a dt6 and create tensor (FA,MD,AD,RD) and Westin Shape Indices (cl, cp, cs) nifti images from a dt6.mat structure. First, a dt6.mat structure will be loaded and eigenvectors and eigenvalues will be extracted using Vistasoft's dtiEig function. The negative eigenvalues are then clipped to 0. Finally, tensors and Westin Shape indices nifti images are computed by using Vistasoft's dtiComputeFA and dtiComputeWestinShapes functions. This is all performed by running the main script.

#### Authors
- Brad Caron (bacaron@iu.edu)
- Soichi Hayashi (hayashi@iu.edu)
- Franco Pestilli (franpest@indiana.edu)

## Running the App 

### On Brainlife.io

You can submit this App online at [https://doi.org/10.25663/bl.app.48](https://doi.org/10.25663/bl.app.48) via the "Execute" tab.

### Running Locally (on your machine)

1. git clone this repo.
2. Inside the cloned directory, create `config.json` with something like the following content with paths to your input files.

```json
{
        "dt6": "./input/dtiinit/"
}
```

### Sample Datasets

You can download sample datasets from Brainlife using [Brainlife CLI](https://github.com/brain-life/cli).

```
npm install -g brainlife
bl login
mkdir input
bl dataset download 5a14f50eeb00be0031340619 && mv 5a14f50eeb00be0031340619 input/dtiinit
```


3. Launch the App by executing `main`

```bash
./main
```

## Output

The main outputs of this App are nifti images of the tensors and Westin Shape indices. These can then be used in app-tractanalysisprofiles.

#### Product.json
The secondary output of this app is `product.json`. This file allows web interfaces, DB and API calls on the results of the processing. 

### Dependencies

This App requires the following libraries when run locally.

  - singularity: https://singularity.lbl.gov/
  - VISTASOFT: https://github.com/vistalab/vistasoft/
  - SPM 8: https://www.fil.ion.ucl.ac.uk/spm/software/spm8/
  - jsonlab: https://github.com/fangq/jsonlab.git
