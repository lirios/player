#include "qmlenvironmentvariable.h"
#include <stdlib.h>

QmlEnvironmentVariable::QmlEnvironmentVariable(QObject *parent) :
  QObject(parent)
{
}

QString
QmlEnvironmentVariable::value(const QString& name)
{
   return getenv(name.toStdString().c_str());
}

void
QmlEnvironmentVariable::setValue(const QString& name, const QString &value)
{
   setenv(name.toStdString().c_str(), value.toStdString().c_str(), 1);
}

void
QmlEnvironmentVariable::unset(const QString& name)
{
   unsetenv(name.toStdString().c_str());
}

QObject *qmlenvironmentvariable_singletontype_provider(QQmlEngine *engine, QJSEngine 
*scriptEngine)
{
   Q_UNUSED(engine)
   Q_UNUSED(scriptEngine)

   return new QmlEnvironmentVariable();
}
