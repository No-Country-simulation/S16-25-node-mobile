import mongoose, { Document, ObjectId } from 'mongoose';

interface Refugio extends Document {
	nombre: string;
	image: string;
	correo: string;
	telefono: string;
	gerente: ObjectId;
	animales: ObjectId[];
	publicaciones: ObjectId[];
}

export type RefugioRequest = Pick<
	Refugio,
	'nombre' | 'correo' | 'telefono' | 'gerente'
> & { image: Express.Multer.File };

export type UpdateRefugioRequest = Partial<RefugioRequest>;

const refugioSchema = new mongoose.Schema<Refugio>(
	{
		nombre: {
			type: String,
			required: true
		},
		image: {
			type: String,
			required: true
		},
		correo: {
			type: String,
			required: true,
			unique: true
		},
		telefono: {
			type: String,
			required: true,
			unique: true
		},
		gerente: {
			type: mongoose.Schema.Types.ObjectId,
			ref: 'User',
			required: true
		},
		animales: [
			{
				type: mongoose.Schema.Types.ObjectId,
				ref: 'Animal'
			}
		],
		publicaciones: [
			{
				type: mongoose.Schema.Types.ObjectId,
				ref: 'Publicacion'
			}
		]
	},
	{ timestamps: true }
);

refugioSchema.set('toJSON', {
	virtuals: true,
	versionKey: false,
	transform: function (doc, ret, options) {
		delete ret._id;
	}
});

export const RefugioModel = mongoose.model('Refugio', refugioSchema);
