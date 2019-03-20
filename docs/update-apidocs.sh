
printf "Clawpack API\n============\n\n" > modules.rst;
printf ".. toctree::\n    :maxdepth: 4\n\n" >> modules.rst;

for d in ../*/src/python; do
    dd=$(basename $(dirname $(dirname $d)));
    echo ;
    echo "APIDOC: $dd";
    printf "    $dd/$dd\n" >> modules.rst;
    rm -rf $dd;
    mkdir $dd;
    sphinx-apidoc -o $dd $d;
    rm $dd/modules.rst
done

for d in riemann; do
    dd=$d;
    pkg=../$d
    echo ;
    echo "APIDOC: $dd";
    printf "    $dd/$dd\n" >> modules.rst;
    rm -rf $dd;
    mkdir $dd;
    sphinx-apidoc -o $dd $pkg;
    rm $dd/modules.rst
done

for d in pyclaw; do
    dd=$d;
    pkg=../$d/src/$d;
    echo ;
    echo "APIDOC: $dd";
    printf "    $dd/$dd\n" >> modules.rst;
    rm -rf $dd;
    mkdir $dd;
    sphinx-apidoc -o $dd $pkg;
    rm $dd/modules.rst
done
