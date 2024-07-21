import mongoose, { Document, ObjectId } from 'mongoose';

interface Rating extends Document {
	rate: number;
	texto: string;
	user?: ObjectId;
	refugio?: ObjectId;
}

export type RatingRequest = Pick<Rating, 'rate' | 'texto' | 'user' | 'refugio'>;
export type UpdateRatingRequest = Partial<RatingRequest>;

const ratingSchema = new mongoose.Schema<Rating>({
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

export const RatingModel = mongoose.model('Calificacion', ratingSchema);
