class Workout{
  String _name ;
  String _duration;
  String _image;

  Workout(this._name,this._duration,this._image);

  String get name {
    return _name;
  }

  String get duration {
    return _duration;
  }

  String get image {
    return _image;
  }

  @override
  String toString(){
    return 'Workout Name: $name, Duration: $duration ';
  }


}

List<Workout> legs = [
  Workout('Squats','05:00','assets/leg1.jpg'),
  Workout('Lunges ','12x','assets/leg2.jpg'),
  Workout('Leg press','15x','assets/leg3.jpg'),
  Workout('Hamstring curls','02:00','assets/leg4.jpg'),
];


List<Workout> chests = [
  Workout('press','10x','assets/chest1.jpg'),
  Workout('Dumbbell flyes','12x','assets/chest2.jpg'),
  Workout('Push-ups','15x','assets/chest3.jpg'),
  Workout('Incline bench press','02:00','assets/chest4.jpg'),
];



List<Workout> arms = [
  Workout('Bicep curls','10x','assets/arms1.jpg'),
  Workout('Tricep dips','12x','assets/arms2.jpg'),
  Workout('Hammer curls','15x','assets/arms3.jpg'),
  Workout('Tricep kickbacks','02:00','assets/arms4.jpg'),
];

List<Workout> back = [
  Workout('Deadlifts','10x','assets/back1.jpg'),
  Workout('Lat pulldowns','12x','assets/back2.jpg'),
  Workout('Barbell rows','15x','assets/back3.jpg'),
  Workout('Face pulls','02:00','assets/back4.jpg'),
];