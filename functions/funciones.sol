// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Funciones {
    address[] public direcciones;

    function nuevaDireccion() public {
        direcciones.push(msg.sender);
    }

    bytes32 public hashGenerado;

    function generarHash(string memory _datos) public {
        hashGenerado = keccak256(abi.encodePacked(_datos));
    }

    struct Comida {
        string nombre;
        string ingredientes;
    }

    Comida public hamburguesa;

    function setHamburguesa(string memory _ingredientes) public {
        hamburguesa = Comida("hamburguesa", _ingredientes);
    }

    struct Alumno {
        string nombre;
        address direccion;
        uint edad;
    }

    bytes32 public hashIdAlumnoActual;
    Alumno[] public lista;
    mapping(string => bytes32) public alumnos;

    function calcularHashAlumno(string memory _nombre, address _direccion, uint _edad) private pure returns (bytes32) {
        return keccak256(abi.encodePacked(_nombre, _direccion, _edad));
    }

    function nuevoAlumno(string memory _nombre, uint _edad) public {
        lista.push(Alumno(_nombre, msg.sender, _edad));
        bytes32 hashAlumno = calcularHashAlumno(_nombre, msg.sender, _edad);
        hashIdAlumnoActual = hashAlumno;
        alumnos[_nombre] = hashAlumno;
    }
}
