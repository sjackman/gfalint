# gfalint: Check a GFA file for syntax errors

Graphical Fragment Assembly (GFA) is a genome sequence assembly graph file format.

See the [Graphical Fragment Assembly (GFA) Format Specification](https://github.com/GFA-spec/GFA-spec).

# Compile gfalint

```sh
./autogen.sh
./configure
make
```

# Run gfalint

```
./gfalint <examples/sample1.gfa
./gfalint <examples/sample2.gfa
```
