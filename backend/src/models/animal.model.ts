import mongoose, { Document, ObjectId } from 'mongoose';
export interface Animal extends Document {
	nombre: string;
	especie: string;
	edad: number;
	peso: number;
	image: string;
	estado: string;
	refugio: ObjectId;
}

export type createAnimalRequest = Pick<
	Animal,
	'nombre' | 'especie' | 'edad' | 'peso' | 'estado'
> & {
	image: Express.Multer.File;
};

export type updateAnimalRequest = Partial<createAnimalRequest>;

const animalSchema = new mongoose.Schema<Animal>(
	{
		nombre: {
			type: String,
			required: true,
			unique: true
		},
		especie: {
			type: String,
			enum: ['Perro', 'Gato', 'Reptil', 'Ave', 'Otros'],
			default: 'Perro'
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
		},
		refugio: {
			type: mongoose.Schema.Types.ObjectId,
			ref: 'Refugio',
			required: true
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
