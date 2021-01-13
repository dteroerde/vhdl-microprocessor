@echo off
set xv_path=C:\\eda\\Xilinx\\Vivado\\2016.4\\bin
call %xv_path%/xelab  -wto b1854b6fb61b4eb9b3924f4245c7d6ee -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L secureip --snapshot microprocessor_behav xil_defaultlib.microprocessor -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
