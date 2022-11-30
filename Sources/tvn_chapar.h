#ifndef TVN_CHAPAR_H
#define TVN_CHAPAR_H

#include <QObject>

class TvnChapar : public QObject
{
    Q_OBJECT
public:
    explicit TvnChapar(QObject *root, QObject *parent = nullptr);

signals:

public slots:

private:
    QObject *root;
};

#endif // TVN_CHAPAR_H
