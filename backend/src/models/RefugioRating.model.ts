import mongoose, { Document, ObjectId } from 'mongoose';
import { User } from './user.model';

interface RefugioRating extends Document {
	rate: number;
	texto: string;
	user: ObjectId;
	refugio: ObjectId;
}

export type RefugioRatingRequest = Pick<
	RefugioRating,
	'rate' | 'texto' | 'refugio'
> & { user: User };

export type UpdateRefugioRatingRequest = Partial<RefugioRatingRequest>;

const refugioRatingSchema = new mongoose.Schema<RefugioRating>({
	rate: {
		type: Number,
		min: 1,
		max: 5,
		default: 5,
		required: true
	},
	texto: {
		type: String,
		required: true
	},
	user: {
		type: mongoose.Schema.Types.ObjectId
	},
	refugio: {
		type: mongoose.Schema.Types.ObjectId
	}
});

refugioRatingSchema.set('toJSON', {
	virtuals: true,
	versionKey: false,
	transform: function (doc, ret, options) {
		delete ret._id;
	}
});

export const RefugioRatingModel = mongoose.model(
	'RefugioCalificacion',
	refugioRatingSchema
);
