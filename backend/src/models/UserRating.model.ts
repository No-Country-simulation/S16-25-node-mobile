import mongoose, { Document, ObjectId } from 'mongoose';
import { User } from './user.model';

interface UserRating extends Document {
	rate: number;
	texto: string;
	user: ObjectId;
	refugio: ObjectId;
}

export type UserRatingRequest = Pick<
	UserRating,
	'rate' | 'texto' | 'refugio'
> & {
	user: User;
};

export type UpdateUserRatingRequest = Partial<UserRatingRequest>;

const userRatingSchema = new mongoose.Schema<UserRating>({
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

userRatingSchema.set('toJSON', {
	virtuals: true,
	versionKey: false,
	transform: function (doc, ret, options) {
		delete ret._id;
	}
});

export const UserRatingModel = mongoose.model(
	'UserCalificacion',
	userRatingSchema
);
