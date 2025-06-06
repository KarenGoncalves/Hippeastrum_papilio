#!/bin/sh

SPECIES=Hippeastrum_papilio

cd $SCRATCH/Hippeastrum_papilio
mkdir slurms results_annotation 

module --force purge

#ml = module load
ml StdEnv/2020 gcc/9.3.0 boost/1.72.0 perl/5.30.2 java scipy-stack
ml tmhmm/2.0c bowtie2/2.4.1 trinity/2.14.0 transdecoder/5.5.0
ml blast+/2.13.0 infernal/1.1.4 trinotate/4.0.0 openmpi gsl
ml augustus/3.5.0 hmmer/3.3.2
ml metaeuk/6 prodigal/2.6.3 r/4.3.1 bbmap/38.86

module save annotation_modules

echo "anyio==3.7.1+computecanada
arff==0.9+computecanada
argon2_cffi==23.1.0+computecanada
argon2_cffi_bindings==21.2.0+computecanada
asttokens==2.2.1+computecanada
async_generator==1.10+computecanada
attrs==23.1.0+computecanada
backcall==0.2.0+computecanada
backports-abc==0.5+computecanada
backports.shutil_get_terminal_size==1.0.0+computecanada
bcrypt==4.0.1+computecanada
beautifulsoup4==4.12.2+computecanada
biopython==1.84+computecanada
bitarray==2.8.1+computecanada
bitstring==4.1.1+computecanada
bleach==6.0.0+computecanada
busco==5.7.0+computecanada
certifi==2023.7.22+computecanada
cffi==1.15.1+computecanada
chardet==5.2.0+computecanada
charset_normalizer==3.2.0+computecanada
comm==0.1.4+computecanada
contourpy==1.1.0+computecanada
cryptography==39.0.1+computecanada
cycler==0.11.0+computecanada
Cython==0.29.36+computecanada
deap==1.4.1+computecanada
debugpy==1.6.7.post1+computecanada
decorator==5.1.1+computecanada
defusedxml==0.7.1+computecanada
dnspython==2.4.2+computecanada
ecdsa==0.18.0+computecanada
entrypoints==0.4+computecanada
exceptiongroup==1.1.3+computecanada
executing==1.2.0+computecanada
fastjsonschema==2.18.0+computecanada
fonttools==4.42.1+computecanada
funcsigs==1.0.2+computecanada
idna==3.4+computecanada
importlib_metadata==6.8.0+computecanada
importlib_resources==6.0.1+computecanada
ipykernel==6.25.1+computecanada
ipython==8.15.0+computecanada
ipython_genutils==0.2.0+computecanada
jedi==0.19.0+computecanada
Jinja2==3.1.2+computecanada
jsonschema==4.19.0+computecanada
jsonschema_specifications==2023.7.1+computecanada
jupyter_client==8.3.1+computecanada
jupyter_core==5.3.1+computecanada
kiwisolver==1.4.5+computecanada
lockfile==0.12.2+computecanada
MarkupSafe==2.1.3+computecanada
matplotlib==3.7.2+computecanada
matplotlib_inline==0.1.6+computecanada
mistune==3.0.1+computecanada
mock==5.1.0+computecanada
mpmath==1.3.0+computecanada
nest_asyncio==1.5.7+computecanada
netaddr==0.8.0+computecanada
netifaces==0.11.0+computecanada
nose==1.3.7+computecanada
numpy==1.25.2+computecanada
packaging==23.1+computecanada
pandas==2.1.0+computecanada
pandocfilters==1.5.0+computecanada
paramiko==3.3.1+computecanada
parso==0.8.3+computecanada
path==16.7.1+computecanada
path.py==12.5.0+computecanada
pathlib2==2.3.7.post1+computecanada
paycheck==1.0.2+computecanada
pbr==5.11.1+computecanada
pexpect==4.8.0+computecanada
pickleshare==0.7.5+computecanada
Pillow==10.0.0+computecanada
pkgutil_resolve_name==1.3.10+computecanada
platformdirs==2.6.2+computecanada
prometheus_client==0.17.1+computecanada
prompt_toolkit==3.0.39+computecanada
psutil==5.7.0
ptyprocess==0.7.0+computecanada
pure_eval==0.2.2+computecanada
pycparser==2.21+computecanada
Pygments==2.16.1+computecanada
PyNaCl==1.5.0+computecanada
pyparsing==3.0.9+computecanada
pyrsistent==0.19.3+computecanada
python-dateutil==2.8.2+computecanada
python_json_logger==2.0.7+computecanada
pytz==2023.3+computecanada
PyYAML==6.0.1+computecanada
pyzmq==25.1.1+computecanada
referencing==0.30.2+computecanada
requests==2.31.0+computecanada
rfc3339_validator==0.1.4+computecanada
rfc3986_validator==0.1.1+computecanada
rpds_py==0.10.0+computecanada
scipy==1.11.2+computecanada
Send2Trash==1.8.2+computecanada
simplegeneric==0.8.1+computecanada
singledispatch==4.1.0+computecanada
six==1.16.0+computecanada
sniffio==1.3.0+computecanada
soupsieve==2.4.1+computecanada
stack_data==0.6.2+computecanada
sympy==1.12+computecanada
terminado==0.17.1+computecanada
testpath==0.6.0+computecanada
tinycss2==1.2.1+computecanada
tornado==6.3.3+computecanada
traitlets==5.9.0+computecanada
typing_extensions==4.7.1+computecanada
tzdata==2023.3+computecanada
urllib3==2.0.4+computecanada
wcwidth==0.2.6+computecanada
webencodings==0.5.1+computecanada
websocket_client==1.6.2+computecanada
XlsxWriter==1.4.3
zipp==3.16.2+computecanada" > ~/requirements.txt

virtualenv ~/trinotateAnnotation
source ~/trinotateAnnotation/bin/activate
pip install --upgrade pip
pip install -r ~/requirements.txt

mkdir -p ~/busco_downloads/lineages
cd ~/busco_downloads/lineages
wget https://busco-data.ezlab.org/v5/data/lineages/liliopsida_odb10.2024-01-08.tar.gz
tar -xvf liliopsida_odb10.2024-01-08.tar.gz

#module restore annotation_modules
#source ~/trinotateAnnotation/bin/activate

#DATA_DIR=/project/def-desgagne/trinotate_data
#
#export EGGNOG_DATA_DIR=${DATA_DIR}
#
#cd $SCRATCH/${SPECIES}
#
#
#Trinotate --db ${DATA_DIR}/Trinotate.sqlite\
# --create\
# --trinotate_data_dir ${DATA_DIR}

module --force purge
ml StdEnv/2020 scipy-stack/2020a

virtualenv ~/eggnog
source ~/eggnog/bin/activate

pip install --upgrade pip
pip install eggnog_mapper==2.1.6+computecanada
