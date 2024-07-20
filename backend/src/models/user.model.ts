import mongoose, { Document } from "mongoose";

export interface User extends Document {
    nombre: string;
    fechaDeNacimiento: string;
    Rol: string;
    telefono: number;
    email: string;
    password: string;
    poseeAnimales: boolean;
    conviveNiños: boolean;
    patio: boolean;
    dimensiones: number;
    direccion: string;
    imagenPerfil: string;
    animales: Animal
    donaciones: Donacion
    denuncias: Denuncias
    calificaciones: Calificación
}
//const mongoose = require('mongoose'); // Erase if already required


// Declare the Schema of the Mongo model
var userSchema = new mongoose.Schema({
    nombre: {
        type: String,
        required: true,
        unique: true,
        index: true,
    },
    rol: {
        type: String,
        enum: ['Admin', 'User', 'Gerente'],
        default: 'user'
    }, 
    telefono: {
        type: String,
        required: true,
        unique: true,
    },
    email: {
        type: String,
        required: true,
        unique: true,
    },
    password: {
        type: String,
        required: true,
    },
    poseeAnimales: {
        type: Boolean,
        default: false,
    },
    conviveNiños: {
        type: Boolean,
        default: false,
    },
    patio: {
        type: Boolean,
        default: false,
    },
    dimensiones: {
        type: Number,
        default: 0
    },
    direccion: {
        type: String,
        requierd: true,
        unique: true,
    },
    imagenPerfil:{
        type: String,
    },
    animales: [
        {
            type: mongoose.Schema.Types.ObjectId,
                ref: 'Animal'
        }
    ],
    donaciones: [
        {
            type: mongoose.Schema.Types.ObjectId,
                ref: 'Donacion'
        }
    ],
    denuncias: [
        {
            type: mongoose.Schema.Types.ObjectId,
                ref: 'Denuncia'
        }
    ],
    calificaciones: [
        {
            type: mongoose.Schema.Types.ObjectId,
                ref: 'Calificacion'
        }
    ]
});

//Export the model
module.exports = mongoose.model('User', userSchema);