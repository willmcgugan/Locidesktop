
echo
echo -------------------------------------------------------------
echo This will download some essential files and set up the DB
echo -------------------------------------------------------------
echo
read -p "Hit Return to continue, or Ctrl+C to exit" wait
echo

python manage.py syncdb
python manage.py init_desktop

mkdir media/iconsets

if [ ! -f crystal_project.tar.gz ]
then
wget http://www.everaldo.com/crystal/crystal_project.tar.gz
fi
tar xvfz crystal_project.tar.gz
mv -n crystal_project media/iconsets/crystal_project

if [ ! -f media/iconsets/crystal_project/iconset.cfg ]
then
echo "[iconset]" > media/iconsets/crystal_project/iconset.cfg
echo "paths=[SIZE]x[SIZE]/[CATEGORY]/[NAME].png" >> media/iconsets/crystal_project/iconset.cfg
fi

if [ ! -f top-1m.csv ]
then
wget http://s3.amazonaws.com/alexa-static/top-1m.csv.zip
unzip top-1m.csv.zip
fi

python manage.py icons import crystal_project
python manage.py icons makepreviews
python manage.py icons makeadminpreviews

python manage.py loadurls top-1m.csv 1000

echo
echo ----------------------------------------------------------
echo Now you can run 'python manage.py runserver'
echo ----------------------------------------------------------
echo