# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

BibleBook.where(book_ja: '創世記', book_en: 'Genesis').first_or_create
BibleBook.where(book_ja: '出エジプト記', book_en: 'Exodus').first_or_create
BibleBook.where(book_ja: 'レビ記', book_en: 'Leviticus').first_or_create
BibleBook.where(book_ja: '民数記', book_en: 'Numbers').first_or_create
BibleBook.where(book_ja: '申命記', book_en: 'Deuteronomy').first_or_create
BibleBook.where(book_ja: 'ヨシュア記', book_en: 'Joshua').first_or_create
BibleBook.where(book_ja: '士師記', book_en: 'Judges').first_or_create
BibleBook.where(book_ja: 'ルツ記', book_en: 'Ruth').first_or_create
BibleBook.where(book_ja: 'サムエル記第一', book_en: '1 Samuel').first_or_create
BibleBook.where(book_ja: 'サムエル記第二', book_en: '2 Samuel').first_or_create
BibleBook.where(book_ja: '列王記第一', book_en: '1 Kings').first_or_create
BibleBook.where(book_ja: '列王記第二', book_en: '2 Kings').first_or_create
BibleBook.where(book_ja: '歴代誌第一', book_en: '1 Chronicles').first_or_create
BibleBook.where(book_ja: '歴代誌第二', book_en: '2 Chronicles').first_or_create
BibleBook.where(book_ja: 'エズラ記', book_en: 'Ezra').first_or_create
BibleBook.where(book_ja: 'ネヘミア記', book_en: 'Nehemiah').first_or_create
BibleBook.where(book_ja: 'エステル記', book_en: 'Esther').first_or_create
BibleBook.where(book_ja: 'ヨブ記', book_en: 'Job').first_or_create
BibleBook.where(book_ja: '詩篇', book_en: 'Psalms').first_or_create
BibleBook.where(book_ja: '箴言', book_en: 'Proverbs').first_or_create
BibleBook.where(book_ja: '伝道者の書', book_en: 'Ecclesiastes').first_or_create
BibleBook.where(book_ja: '雅歌', book_en: 'Song of Solomon').first_or_create
BibleBook.where(book_ja: 'イザヤ書', book_en: 'Isaiah').first_or_create
BibleBook.where(book_ja: 'エレミア書', book_en: 'Jeremiah').first_or_create
BibleBook.where(book_ja: '哀歌', book_en: 'Lamentations').first_or_create
BibleBook.where(book_ja: 'エゼキエル書', book_en: 'Ezekiel').first_or_create
BibleBook.where(book_ja: 'ダニエル書', book_en: 'Daniel').first_or_create
BibleBook.where(book_ja: 'ホセア書', book_en: 'Hosea').first_or_create
BibleBook.where(book_ja: 'ヨエル書', book_en: 'Joel').first_or_create
BibleBook.where(book_ja: 'アモス書', book_en: 'Amos').first_or_create
BibleBook.where(book_ja: 'オバデア書', book_en: 'Obadiah').first_or_create
BibleBook.where(book_ja: 'ヨナ書', book_en: 'Jonah').first_or_create
BibleBook.where(book_ja: 'ミカ書', book_en: 'Micah').first_or_create
BibleBook.where(book_ja: 'ナホム書', book_en: 'Nahum').first_or_create
BibleBook.where(book_ja: 'ハバクク書', book_en: 'Habakkuk').first_or_create
BibleBook.where(book_ja: 'ゼパニア書', book_en: 'Zephaniah').first_or_create
BibleBook.where(book_ja: 'ハガイ書', book_en: 'Haggai').first_or_create
BibleBook.where(book_ja: 'ゼカリア書', book_en: 'Zechariah').first_or_create
BibleBook.where(book_ja: 'マラキ書', book_en: 'Malachi').first_or_create
BibleBook.where(book_ja: 'マタイの福音書', book_en: 'Matthew').first_or_create
BibleBook.where(book_ja: 'マルコの福音書', book_en: 'Mark').first_or_create
BibleBook.where(book_ja: 'ルカの福音書', book_en: 'Luke').first_or_create
BibleBook.where(book_ja: 'ヨハネの福音書', book_en: 'John').first_or_create
BibleBook.where(book_ja: '使徒の働き', book_en: 'Acts').first_or_create
BibleBook.where(book_ja: 'ローマ人への手紙', book_en: 'Romans').first_or_create
BibleBook.where(book_ja: 'コリント人への手紙第一', book_en: '1 Corinthians').first_or_create
BibleBook.where(book_ja: 'コリント人への手紙第二', book_en: '2 Corinthians').first_or_create
BibleBook.where(book_ja: 'ガラテア人への手紙', book_en: 'Galatians').first_or_create
BibleBook.where(book_ja: 'エペソ人への手紙', book_en: 'Ephesians').first_or_create
BibleBook.where(book_ja: 'ピリピ人への手紙', book_en: 'Philippians').first_or_create
BibleBook.where(book_ja: 'コロサイ人への手紙', book_en: 'Colossians').first_or_create
BibleBook.where(book_ja: 'テサロニケ人への手紙第一', book_en: '1 Thessalonians').first_or_create
BibleBook.where(book_ja: 'テサロニケ人への手紙第二', book_en: '2 Thessalonians').first_or_create
BibleBook.where(book_ja: 'テモテへの手紙第一', book_en: '1 Timothy').first_or_create
BibleBook.where(book_ja: 'テモテへの手紙第二', book_en: '2 Timothy').first_or_create
BibleBook.where(book_ja: 'テトスへの手紙', book_en: 'Titus').first_or_create
BibleBook.where(book_ja: 'ピレモンへの手紙', book_en: 'Philemon').first_or_create
BibleBook.where(book_ja: 'ヘブル人への手紙', book_en: 'Hebrews').first_or_create
BibleBook.where(book_ja: 'ヤコブの手紙', book_en: 'James').first_or_create
BibleBook.where(book_ja: 'ペテロの手紙第一', book_en: '1 Peter').first_or_create
BibleBook.where(book_ja: 'ペテロの手紙第二', book_en: '2 Peter').first_or_create
BibleBook.where(book_ja: 'ヨハネの手紙第一', book_en: '1 John').first_or_create
BibleBook.where(book_ja: 'ヨハネの手紙第二', book_en: '2 John').first_or_create
BibleBook.where(book_ja: 'ヨハネの手紙第三', book_en: '3 John').first_or_create
BibleBook.where(book_ja: 'ユダの手紙', book_en: 'Jude').first_or_create
BibleBook.where(book_ja: 'ヨハネの黙示録', book_en: 'Revelation').first_or_create



