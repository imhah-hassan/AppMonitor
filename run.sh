cd /home/hassan/AppMonitor
rm -rf log/*
robot -d log gop_jobs.robot
python ParseOutput.py log/output.xml log
mv log/output_*.log /var/log/AppMonitor/
