import * as sdk from 'microsoft-cognitiveservices-speech-sdk';
import { Injectable, Logger } from '@nestjs/common';
import * as fs from 'fs';
import * as path from 'path';

@Injectable()
export class SpeechService {
  private readonly logger = new Logger(SpeechService.name);

  async assessPronunciation(
    audioPath: string,
    referenceText: string,
  ): Promise<any> {
    try {
      const speechKey = process.env.AZURE_SPEECH_KEY;
      const speechRegion = process.env.AZURE_SPEECH_REGION;

      if (!speechKey || !speechRegion) {
        throw new Error(
          'Azure Speech credentials not configured. Please set AZURE_SPEECH_KEY and AZURE_SPEECH_REGION in .env',
        );
      }

      const speechConfig = sdk.SpeechConfig.fromSubscription(
        speechKey,
        speechRegion,
      );

      speechConfig.speechRecognitionLanguage = 'zh-CN';

      // Đọc file audio
      const audioData = fs.readFileSync(audioPath);
      const audioConfig = sdk.AudioConfig.fromWavFileInput(audioData);

      const recognizer = new sdk.SpeechRecognizer(
        speechConfig,
        audioConfig,
      );

      // Cấu hình Pronunciation Assessment
      const pronunciationConfig = new sdk.PronunciationAssessmentConfig(
        referenceText,
        sdk.PronunciationAssessmentGradingSystem.HundredMark,
        sdk.PronunciationAssessmentGranularity.Phoneme,
        true,
      );

      pronunciationConfig.applyTo(recognizer);

      return new Promise((resolve, reject) => {
        recognizer.recognizeOnceAsync(
          (result) => {
            recognizer.close();
            
            // Xóa file audio tạm sau khi xử lý
            try {
              if (fs.existsSync(audioPath)) {
                fs.unlinkSync(audioPath);
              }
            } catch (err) {
              this.logger.warn(`Failed to delete temp audio file: ${audioPath}`, err);
            }

            if (result.reason === sdk.ResultReason.RecognizedSpeech) {
              const paResult =
                sdk.PronunciationAssessmentResult.fromResult(result);

              // Trích xuất chi tiết từng từ với syllables và phonemes
              const wordsDetail = (paResult.detailResult?.Words || []).map((word: any) => ({
                Word: word.Word,
                AccuracyScore: word.AccuracyScore,
                ErrorType: word.ErrorType,
                Offset: word.Offset,
                Duration: word.Duration,
                Syllables: word.Syllables?.map((syllable: any) => ({
                  Syllable: syllable.Syllable,
                  AccuracyScore: syllable.AccuracyScore,
                  Offset: syllable.Offset,
                  Duration: syllable.Duration,
                })) || [],
                Phonemes: word.Phonemes?.map((phoneme: any) => ({
                  Phoneme: phoneme.Phoneme,
                  AccuracyScore: phoneme.AccuracyScore,
                  Offset: phoneme.Offset,
                  Duration: phoneme.Duration,
                })) || [],
              }));

              const response = {
                text: result.text,
                pronunciationScore: paResult.pronunciationScore,
                accuracyScore: paResult.accuracyScore,
                fluencyScore: paResult.fluencyScore,
                completenessScore: paResult.completenessScore,
                words: wordsDetail,
              };

              this.logger.log(
                `Pronunciation assessment completed. Score: ${paResult.pronunciationScore}, Words: ${wordsDetail.length}`,
              );
              resolve(response);
            } else if (result.reason === sdk.ResultReason.NoMatch) {
              reject(
                new Error(
                  'Không thể nhận diện giọng nói. Vui lòng thử lại với chất lượng âm thanh tốt hơn.',
                ),
              );
            } else {
              reject(
                new Error(
                  result.errorDetails ||
                    'Lỗi khi xử lý phát âm. Vui lòng thử lại.',
                ),
              );
            }
          },
          (error) => {
            recognizer.close();
            
            // Xóa file audio tạm khi có lỗi
            try {
              if (fs.existsSync(audioPath)) {
                fs.unlinkSync(audioPath);
              }
            } catch (err) {
              this.logger.warn(`Failed to delete temp audio file: ${audioPath}`, err);
            }

            this.logger.error('Speech recognition error:', error);
            reject(
              new Error(
                error || 'Lỗi khi kết nối với Azure Speech Service.',
              ),
            );
          },
        );
      });
    } catch (error: any) {
      this.logger.error('Error in assessPronunciation:', error);
      
      // Xóa file audio tạm khi có lỗi
      try {
        if (fs.existsSync(audioPath)) {
          fs.unlinkSync(audioPath);
        }
      } catch (err) {
        this.logger.warn(`Failed to delete temp audio file: ${audioPath}`, err);
      }

      throw error;
    }
  }

  async textToSpeech(text: string, language: string = 'zh-CN'): Promise<Buffer> {
    try {
      const speechKey = process.env.AZURE_SPEECH_KEY;
      const speechRegion = process.env.AZURE_SPEECH_REGION;

      if (!speechKey || !speechRegion) {
        throw new Error(
          'Azure Speech credentials not configured. Please set AZURE_SPEECH_KEY and AZURE_SPEECH_REGION in .env',
        );
      }

      const speechConfig = sdk.SpeechConfig.fromSubscription(
        speechKey,
        speechRegion,
      );

      // Cấu hình ngôn ngữ và giọng nói
      speechConfig.speechSynthesisLanguage = language;
      // Sử dụng giọng nữ tiếng Trung phổ biến
      if (language === 'zh-CN') {
        speechConfig.speechSynthesisVoiceName = 'zh-CN-XiaoxiaoNeural';
      } else {
        speechConfig.speechSynthesisVoiceName = 'zh-CN-XiaoxiaoNeural';
      }

      const synthesizer = new sdk.SpeechSynthesizer(speechConfig, null);

      return new Promise((resolve, reject) => {
        synthesizer.speakTextAsync(
          text,
          (result) => {
            synthesizer.close();
            
            if (result.reason === sdk.ResultReason.SynthesizingAudioCompleted) {
              resolve(Buffer.from(result.audioData));
            } else if (result.reason === sdk.ResultReason.Canceled) {
              const cancellation = sdk.CancellationDetails.fromResult(result);
              reject(
                new Error(
                  `Speech synthesis canceled: ${cancellation.reason}. ${cancellation.errorDetails}`,
                ),
              );
            } else {
              reject(new Error(`Speech synthesis failed: ${result.reason}`));
            }
          },
          (error) => {
            synthesizer.close();
            this.logger.error('Speech synthesis error:', error);
            reject(
              new Error(
                error || 'Lỗi khi kết nối với Azure Speech Service.',
              ),
            );
          },
        );
      });
    } catch (error: any) {
      this.logger.error('Error in textToSpeech:', error);
      throw error;
    }
  }
}

