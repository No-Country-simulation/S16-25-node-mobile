import mongoose, { Document, ObjectId } from 'mongoose';

interface Post extends Document {
	titulo: string;
	texto: string;
	image: string;
	status: string;
	refugio: ObjectId;
}

export type PostRequest = Pick<
	Post,
	'titulo' | 'texto' | 'status' | 'refugio'
> & {
	image: Express.Multer.File;
};

export type UpdatePostRequest = Partial<PostRequest>;

const postSchema = new mongoose.Schema<Post>(
	{
		titulo: {
			type: String,
			required: true
		},
		texto: {
			type: String,
			required: true
		},
		image: {
			type: String,
			required: true
		},
		status: {
			type: String,
			enum: ['ACTIVO', 'INACTIVO'],
			default: 'ACTIVO'
		},
		refugio: {
			type: mongoose.Schema.Types.ObjectId,
			required: true
		}
	},
	{ timestamps: true }
);

postSchema.set('toJSON', {
	virtuals: true,
	versionKey: false,
	transform: function (doc, ret, options) {
		delete ret._id;
	}
});

export const PostModel = mongoose.model('Publicacion', postSchema);
