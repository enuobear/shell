use strict;

# old hash
my $old_hash = qx(ssh krwhite_admin "cd /home/mgsys/sg-gcard-kr &&  git rev-parse HEAD");
chomp($old_hash);

#for test
#$old_hash = "0d7a519b0f3192df0c7716c2b4fbd6845c71478c";

# check branch
my $is_master_kr = qx(cd /data/master_kr && git branch --no-color | grep master_kr | grep \* | wc -l);
unless($is_master_kr){
    qx(cd /data/master_kr && git checkout master_kr);
}

# git pull
qx(cd /data/master_kr &&  git pull origin master_kr );


# new hash
my $new_hash = qx(cd /data/master_kr  && git rev-parse HEAD );
chomp($new_hash);

my $diff_hash = $old_hash."..".$new_hash;

my $pull_request = "";

# pull request
my $result = qx(cd /data/master_kr && git log $diff_hash | grep "Merge pull request");
if($result =~ /\#(\d+)\D/){
    $pull_request = "https://github.dena.jp/global/sg-gcard-kr/pull/$1";
}

# filelist
my $filelist = qx(cd /data/master_kr && git diff --name-only $diff_hash);
chomp($filelist);

# date
my $date;
{
    my ($d,$m,$y) = (localtime)[3..5];
    $date = ($y+1900)."/".($m+1)."/".$d;
}

# output 
print <<CODE;

上线时间：$date

上线内容：
$pull_request

代码冻结后的bugfix：
上线步骤：（考虑代码，服务器设置，数据变化，脚本执行，缓存清理等）

{code}
cd /home/mgsys/sg-gcard-kr

git checkout master_kr【如果当前在master_kr分支忽略该步骤 git branch 查看当前位于哪个分支】

git pull origin master_kr

cd ~/deploy-production
cap -s from=$old_hash -s to=$new_hash get_file_names
cat /home/mgsys/deploy-production/file_list #检查文件列表是否正确
-------------------------------------------------------------------------
$filelist
-------------------------------------------------------------------------

cap production put_files 
cap production deploy:restart
{code}


回滚步骤：

{code}
git reset --keep $old_hash
cap production put_files
{code}


CODE
