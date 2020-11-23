# Game-on

## Team
- Davide Bazzana
- Giacomo Colizzi Coin
- Renato Giamba

## Descrizione

Game-on è una piattaforma web che consente di giocare e condividere giochi. Infatti, come utente registrato del sito, si può sia giocare ai giochi
degli altri che scriverne di propri per poi condividerli sulla piattaforma. Gli utenti registrati possono esprimere il proprio parere sui giochi
disponibili aggiungendo commenti o assegnando un like o dislike. Ogni utente può inoltre creare una lista dei giochi preferiti che costituisce una
collezione di quelli che più gli sono piaciuti. Infine la piattaforma offre la possibilità agli utenti di interagire tra di loro. L'utente può infatti
mandare ad un altro utente una richiesta di amicizia la quale, una volta accettata dall'altro utente, permette di inviare e ricevere inviti ai giochi.

## Servizi esterni utilizzati

- Google OAuth
- GitHub OAuth
- Unity APIs

---

## User stories

1) Registrazione di un account:
\newline
<br>Come visitatore
\newline
<br>In modo che il sistema possa ricordarsi di me
\newline
<br>Voglio creare un nuovo account

2) Login:
\newline
<br>Come utente registrato
\newline
<br>In modo che possa interagire col sistema
\newline
<br>Voglio effetuare il login

3) Modifica account:
\newline
<br>Come utente registrato
\newline
<br>In modo da cambiare le informazioni che mi riguardano
\newline
<br>Voglio modificare il mio account

4) OAuth:
\newline
<br>Come visitatore
\newline
<br>In modo da usare un account Google esistente per effettuare il login
\newline
<br>Voglio effettuare il login con un account esterno

5) Lista dei giochi (globale) caricati sul sito:
\newline
<br>Come utente registrato/visitatore/amministratore 
\newline
<br>In modo che tutti gli utenti possano vedere i giochi caricati sul sito
\newline
<br>Voglio visualizzare una pagina con tutti i giochi aggiunti dagli utenti registrati del sito

6) Aggiungere gioco alla lista di giochi:
\newline
<br>Come utente registrato
\newline
<br>In modo da inserire un gioco nella lista globale di giochi del sito
\newline
<br>Voglio inserire un gioco nella lista globale

7) Rimuovere gioco dalla lista di giochi:
\newline
<br>Come utente registrato
\newline
<br>In modo da rimuovere dalla lista globale di giochi uno dei giochi che avevo caricato in passato
\newline
<br>Voglio rimuovere un gioco dalla lista globale dei giochi

8) Rimuovi qualsiasi gioco:
\newline
<br>Come amministratore
\newline
<br>In modo da rimuovere dalla lista qualsiasi gioco inserito da un utente registrato
\newline
<br>Voglio rimuovere un gioco dalla lista

9) Giocare ad un gioco:
\newline
<br>Come utente registrato
\newline
<br>In modo da giocare ad un gioco trovato nella lista di giochi globale
\newline
<br>Voglio giocare ad un gioco

10) Modificare descrizione di un gioco:
\newline
<br>Come utente registrato che ha pubblicato il gioco
\newline
<br>In modo da modificare il testo che descrive il gioco
\newline
<br>Voglio modificare la descrizione del gioco

11) Vedere informazioni di un gioco:
\newline
<br>Come visitatore/utente registrato
\newline
<br>In modo da visualizzare le informazioni di un gioco
\newline
<br>Voglio vedere le informazioni di un gioco

12) Inserisci commento gioco:
\newline
<br>Come utente registrato
\newline
<br>In modo da inserire commenti ad un gioco
\newline
<br>Voglio inserire commenti ad un gioco

13) Visualizza commenti di un gioco:
\newline
<br>Come utente registrato
\newline
<br>In modo da visualizzare i commenti relativi ad un gioco
\newline
<br>Voglio vedere i commenti di un gioco

14) Assegna/Rimuovi like:
\newline
<br>Come utente registrato
\newline
<br>In modo da dare un feedback positivo ad un gioco
\newline
<br>Voglio assegnare un like a un gioco nella lista

15) Assegna/Rimuovi dislike:
\newline
<br>Come utente registrato
\newline
<br>In modo da dare un feedback negativo ad un gioco
\newline
<br>Voglio assegnare un dislike a un gioco nella lista

16) Visualizza Lista Favoriti:
\newline
<br>Come utente registrato
\newline
<br>In modo da poter visualizzare la mia (personale) lista di giochi favoriti
\newline
<br>Voglio visualizzare una pagina con tutti i miei giochi favoriti

17) Aggiungi a Lista Favoriti:
\newline
<br>Come utente registrato
\newline
<br>In modo che l’utente possa aggiungere i propri giochi preferiti alla lista favoriti
\newline
<br>Voglio aggiungere un gioco alla mia lista favoriti

18) Rimuovi da Lista Favoriti:
\newline
<br>Come utente registrato
\newline
<br>In modo che l’utente possa rimuovere un gioco dalla propria lista favoriti
\newline
<br>Voglio rimuovere un gioco dalla mia lista favoriti

19) Ricerca per nome:
\newline
<br>Come utente registrato/visitatore
\newline
<br>In modo da cercare solo il gioco di cui conosco il nome
\newline
<br>Voglio cercare un gioco specifico

20) Ricerca per categoria:
\newline
<br>Come utente registrato/visitatore
\newline
<br>In modo da cercare solo ciò che mi interessa
\newline
<br>Voglio cercare i giochi secondo una categoria

21) Ordina risultati di una ricerca:
\newline
<br>Come utente registrato/visitatore
\newline
<br>In modo che possa organizzare i risultati della mia ricerca
\newline
<br>Voglio ordinare i risultati della ricerca

22) Lista utenti:
\newline
<br>Come utente registrato o amministratore
\newline
<br>In modo da cercare un utente registrato
\newline
<br>Voglio cercare un utente registrato

23) Aggiungi amico
\newline
<br> Come utente registrato
\newline
<br> In modo che possa aggiungere un altro utente registrato ad una lista amici
\newline
<br> Voglio giocare e contattare spesso l'utente selezionato

24) Rimuovi amico
\newline
<br> Come utente registrato
\newline
<br> In modo che possa rimuovere un altro utente registrato dalla lista amici
\newline
<br> Non voglio più essere amico dell'utente selezionato

25) Invita amici a giocare
\newline
<br> Come utente registrato
\newline
<br> In modo che alcuni/tutti gli amici ricevano una notifica per giocare insieme ad un gioco multiplayer
\newline
<br> Voglio giocare con i miei amici

26) Lista amici
\newline
<br> Come utente registrato
\newline
<br> In modo che possa vedere gli amici e il loro stato online/offline
\newline
<br> Voglio vedere la lista di tutti i miei amici

27) Conferma registrazione:
\newline
<br>Come visitatore
\newline
<br>In modo da ricevere email di conferma creazione account
\newline
<br>Voglio confermare registrazione tramite email

28) Contatta amministratori:
\newline
<br>Come utente registrato
\newline
<br>In modo da segnalare agli amministratori bug o il comportamento di altri utenti registrati
\newline
<br>Voglio inviare un'email agli amministratori

29) Info amministratori:
\newline
<br>Come visitatore
\newline
<br>In modo da visualizzare info amministratori
\newline
<br>Voglio visualizzare informazioni amministratori

30) Modifica Password smarrita:
\newline
<br>Come utente registrato
\newline
<br>In modo da ricevere email con istruzioni per modificare password
\newline
<br>Voglio modificare password account

31) Rimuovi commento ad un gioco:
\newline
<br> Come amministratore
\newline
<br> In modo che possa rimuovere qualsiasi commento ad un gioco
\newline
<br> Voglio rimuovere un commento che nel contenuto viola le norme della community

32) Elimina utente registrato:
\newline
<br>Come amministratore
\newline
<br>In modo da eliminare l'account di un utente registrato
\newline
<br>Voglio escludere dal sito un utente registrato

33) Contatta utente registrato:
\newline
<br>Come utente registrato
\newline
<br>In modo da segnalare all'utente bug relativi ai suoi giochi
\newline
<br>Voglio inviare un'email all'utente sviluppatore del gioco

34) Rilascia patch di un gioco
\newline
<br> Come utente registrato
\newline
<br> In modo che possa correggere errori di un mio gioco
\newline
<br> Voglio rilasciare una patch per correggere bug di un mio gioco

---
