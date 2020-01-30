# 3D Printing libs & POCs

This is an OpenScad repository where I put all the libraries I design for my pieces along with some examples or proof of concepts.


## Libraries


### Installation

In my case (Linux) I just do (in the base directory of the repository).

```bash
ln -s `pwd`/smh_lib $HOME/.local/share/OpenSCAD/libraries
```

For other OSs, please read the [documentation](https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/Libraries#Library_Locations).


### Documentation
At this moment, I have no fancy documentation. But, I have ensured the code is fully documented, so you can peek into the `.scad` files to read the comments and see some examples. Furthermore, the next section provides some interesting examples using modules from the library in a practical way.


## Proofs of concept
* [Nut & bolt](pocs/nut_n_bolt) (2020-JAN-04)
* [Vertical-printed hinge](pocs/vertical_hinge) with circular support (2020-JAN-09)
* [Origami paper bird](pocs/paper_bird) (2020-JAN-25)
* [Lithophane of a hockey player](pocs/lithophane_maiki) (2020-JAN-29)
