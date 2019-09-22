
# Deformable Linear Objects (DLOs) Modeling (matlab version)

A dynamic model of DLOs (such as cables, wires, etc) in 2D plane. Model the DLOs physically using energy minimum principle
Reference: Static Modeling of Linear Object Deformation Based on Differential Geometry

## Getting Started

### Prerequisites

Require CasaDi (https://web.casadi.org/)

The installation of CasaDi can be found on https://web.casadi.org/get/

## Running

* To run, replace the path in dlodynamics.m:
addpath('/home/jihong/third_party_softs/casadi-linux-matlabR2014b-v3.4.4') to the CaSaDi path on your own computer
* Assign values to four constraints:
```
Lx
Ly
Theta1
Theta2
```
* If the constraints are feasible, the resulting shape will be presented. (The total length of the DLO is assumed to be 1 so (Lx^2 + Ly^2) < 1)

## Authors

* **Jihong Zhu** - *Initial work* - [Jihong Zhu](https://github.com/Jihong-Zhu)

## License

This project is licensed under the Apache License 2.0 License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments
