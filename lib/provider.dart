
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:video_player/video_player.dart';

import 'modelClass.dart';


class ProviderClass with ChangeNotifier{

  int currentSongIndex = 0;
  bool isHeart = false;
  bool isplaying = false;
  List<FavoriteModel> Favoritelist=[];
  VideoPlayerController? playController;
  ChewieController? chewieController;
  AssetsAudioPlayer player = AssetsAudioPlayer.newPlayer();





  List<ModalClass> audioList = [
    ModalClass(
      image: 'assets/image/image1.png',
      songName: 'Channa Ve',
      singerName: ' Akhil Sachdeva',
      song:
      'assets/audio/song1.mp3',),
    ModalClass(
      image: 'assets/image/image2.png',
      songName: 'Chaleya Teri Or',
      singerName: 'Arijit Singh',
      song:
      'assets/audio/song2.mp3',),
    ModalClass(
      image: 'assets/image/image3.png',
      songName: 'Zindagi Tere Naam',
      singerName: 'Sidharth Malhotra',
      song:
      'assets/audio/song3.mp3',),
    ModalClass(
      image: 'assets/image/image4.png',
      songName: 'Teri Baaton Mein Aisa Uljha Jiya',
      singerName: 'Tanishk Bagchi',
      song:
      'assets/audio/song4.mp3',),
    ModalClass(
      image: 'assets/image/image5.png',
      songName: 'Laal Peeli Akhiyaan',
      singerName: 'Romy',
      song:
      'assets/audio/song5.mp3',),
    ModalClass(
      image: 'assets/image/image6.png',
      songName: 'Jo Tu Mere Paas Hai',
      singerName: 'Yohan Marshall',
      song:
      'assets/audio/song6.mp3',),
    ModalClass(
      image: 'assets/image/image8.png',
      songName: 'Balam Pichkari',
      singerName: 'Pritam Chakraborty',
      song:
      'assets/audio/song8.mp3',),
    ModalClass(
      image: 'assets/image/image9.png',
      songName: 'Sooraj Dooba Hain',
      singerName: 'Arijit Singh',
      song:
      'assets/audio/song9.mp3',),
    ModalClass(
      image: 'assets/image/image10.png',
      songName: 'Tum Se Hi',
      singerName: 'Mohit Chauhan',
      song:
      'assets/audio/song10.mp3',),
    ModalClass(
      image: 'assets/image/image11.png',
      songName: 'Pee Loon',
      singerName: 'Irshad Kami',
      song:
      'assets/audio/song11.mp3',),
    ModalClass(
      image: 'assets/image/image12.png',
      songName: 'Itni Si Baat Hain',
      singerName: 'Antara Mitra',
      song:
      'assets/audio/song12.mp3',),
    ModalClass(
      image: 'assets/image/image13.png',
      songName: 'AAJ DIN CHADHEYA',
      singerName: 'Rahat Fateh Ali Khan',
      song:
      'assets/audio/song13.mp3',),
    ModalClass(
      image: 'assets/image/image14.png',
      songName: 'Surili Akhiyon Wale',
      singerName: 'Sajid–Wajid',
      song:
      'assets/audio/song14.mp3',),
    ModalClass(
      image: 'assets/image/image15.png',
      songName: 'Rabba Mein Toh Mar Gaya Oye',
      singerName: 'Shahid Mallya',
      song:
      'assets/audio/song15.mp3',),
  ];
  List<videoModal> videoList = [
    videoModal(
        image: 'assets/image/img.png',
        songName:
        'Main Rang Sharbaton Ka | Arijit Singh | Phata Poster Nikhla Hero | 2013',
        url:
        'assets/video/video1.mp4'),
    videoModal(
        image: 'assets/image/img_1.png',
        songName:
        'Tera Fitoor X Dil Meri Na Sune | Arijit Singh, Atif Aslam | Genius | Utkarsh Sharma, Ishita Chauhan',
        url:
        'assets/video/video2.mp4'),
    videoModal(
        image: 'assets/image/img_2.png',
        songName:
        'Tum Se (Full Video): Shahid Kapoor, Kriti | Sachin-Jigar, Raghav Chaitanya, Varun Jain, Indraneel',
        url:
        'assets/video/video3.mp4'),
    videoModal(
        image: 'assets/image/img_3.png',
        songName:
        'Dil Se Dil Tak (Full Video) | Varun, Janhvi | Akashdeep, Laqshay, Kausar, Suvarna | Sajid N, Nitesh',
        url:
        'assets/video/video4.mp4'),
    videoModal(
        image: 'assets/image/img_4.png',
        songName:
        'Aakhiyan gulab in loop mode | Shahid Kapoor, Kriti Sanon | Mitraz | Teri Baaton Mein Aisa Uljha Jiya',
        url:
        'assets/video/video5.mp4'),
    videoModal(
        image: 'assets/image/img_5.png',
        songName:
        'Teri Baaton Mein Aisa Uljha Jiya (Title Track): Shahid Kapoor, Kriti Sanon | Raghav,Tanishk, Asees',
        url:
        'assets/video/video6.mp4'),
    videoModal(
        image: 'assets/image/img_6.png',
        songName:
        'Piya O Re Piya | Atif Aslam | Shreya Ghoshal | Tere Naal Love Ho Gaya',
        url:
        'assets/video/video7.mp4'),
    videoModal(
        image: 'assets/image/img_7.png',
        songName:
        'Main Hoon Saath Tere - Lyrical | Shaadi Mein Zaroor Aana | Rajkummar Rao, Kriti K | Arijit Singh',
        url:
        'assets/video/video8.mp4'),
    videoModal(
        image: 'assets/image/img_8.png',
        songName:
        'Tu Banja Gali Benaras Ki | Asees Kaur | Shaadi Mein Zaroor Aana | Rajkummar Rao, Kriti Kharbanda',
        url:
        'assets/video/video9.mp4'),
    videoModal(
        image: 'assets/image/img_9.png',
        songName:
        'Jaan Ban Gaye - Khuda Haafiz |Vidyut Jammwal , Shivaleeka O | Mithoon Ft. Vishal Mishra, Asees Kaur',
        url:
        'assets/video/video10.mp4'),
  ];

  getFavoriteDelate(index){
    Favoritelist.removeAt(index);
    notifyListeners();
  }



}