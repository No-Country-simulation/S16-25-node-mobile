import mongoose, { Document } from 'mongoose';
export interface Animal extends Document {
	nombre: string;
	especie: string;
	edad: number;
	peso: number;
	image: string;
	estado: string;
}

export type AnimalRequest = Pick<
	Animal,
	'nombre' | 'especie' | 'edad' | 'peso' | 'estado'
> & {
	image: Express.Multer.File;
};

const animalSchema = new mongoose.Schema<Animal>(
	{
		nombre: {
			type: String,
			required: true,
			unique: true
		},
		especie: {
			type: String,
			required: true
		},
		edad: {
			type: Number,
			required: true
		},
		peso: {
			type: Number,
			required: true
		},
		image: {
			type: String
		},
		estado: {
			type: String,
			enum: ['Activo', 'Pedido', 'Adoptado'],
			default: 'Activo'
		}
	},
	{ timestamps: true }
);

animalSchema.set('toJSON', {
	virtuals: true,
	versionKey: false,
	transform: function (doc, ret, options) {
		delete ret._id;
	}
});

export const AnimalModel = mongoose.model('Animal', animalSchema);
