cd "C:\Users\h.imhah\OneDrive - ONEPOINT\Bureau\pi4"
DEL /S /S log\*
rmdir /Q /S log

robot -d log CCF_HomePage.robot

python ParseOutput.py log\output.xml log
mv log/output_*.log /var/log/AppMonitor/
