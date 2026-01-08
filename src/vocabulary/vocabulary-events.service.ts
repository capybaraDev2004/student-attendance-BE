import { Injectable, MessageEvent } from '@nestjs/common';
import { Observable, Subject } from 'rxjs';
import { map } from 'rxjs/operators';

type VocabularyEventData = MessageEvent['data'];

@Injectable()
export class VocabularyEventsService {
  private readonly updatesSubject = new Subject<VocabularyEventData>();

  emitUpdated(payload: VocabularyEventData) {
    this.updatesSubject.next(payload);
  }

  stream(): Observable<MessageEvent> {
    return this.updatesSubject.asObservable().pipe(
      map((payload): MessageEvent => ({
        type: 'vocabulary.updated',
        data: payload,
      })),
    );
  }
}

