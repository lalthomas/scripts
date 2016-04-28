# android create project \
# --target <target_ID> \
# --name <your_project_name> \
# --path path/to/your/project \
# --activity <your_activity_name> \
# --package <your_package_namespace>

# http://developer.android.com/tools/projects/projects-cmdline.html#CreatingAProject

# !!! you need to import the generated project manually to run the project

JAVA_HOME=/usr/lib/jvm/java-7-oracle


read -p "Enter project name : " projectname

/home/likewise-open/AMRITAVIDYA/p2cse15010/Android/Sdk/tools/android create project \
 --target 1 \
 --name $projectname \
 --path ./$projectname \
 --activity MainActivity \
 --package in.blogspot.lalamboori

echo project created at location at $PWD
